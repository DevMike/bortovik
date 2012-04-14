require 'spec_helper'

describe "Reviews", :js => true do
  sign_in(:user)

  shared_examples_for "pagination" do
    before(:all) { @per_page = Settings.pagination.reviews.pending }

    it "should paginate reviews" do
      reviews_amount = @reviews.count
      visit reviews_path(:type => @type) unless @filters
      page.should have_content("1 - #{@per_page} of #{reviews_amount}")
      (all("tr.odd").count + all("tr.even").count).should == @per_page

      find(".next_page").click
      page.should have_content("#{@per_page+1} - #{reviews_amount} of #{reviews_amount}")
      (all("tr.odd").count + all("tr.even").count).should == reviews_amount - @per_page
    end
  end

  context "common" do
    it "should remember column order" do
      FactoryGirl.create_list(:review, 2, :user => @current_user)
      FactoryGirl.create_list(:review, 3, :rated_company => @current_user.company)

      visit reviews_path

      click_on 'Rating'

      find('#type_pending').click
      find('#type_given').click

      page.should have_css('.button_order.ui-state-focus[data-order-field=rate]')
    end

    it "should opens first non blank tab by default" do
      FactoryGirl.create_list(:review, 2, :rated_company => @current_user.company)

      visit reviews_path
      find('input#type_received').should be_checked
      all('table#reviews tbody tr').size.should eq(2)
    end

    context "should show amount of reviews" do
      before(:all) { @types = ['Given', 'Received', 'Pending'] }

      it "should show amount of any types of reviews" do
        FactoryGirl.create(:review, :rated_company => @current_user.company)
        FactoryGirl.create(:review, :user => @current_user)
        FactoryGirl.create(:customer, :invited_by => @current_user)
        visit reviews_path
        @types.each do |type|
          page.should have_content("#{type} (1)")
        end
      end

      it "should not display pending number if no pendings" do
        visit reviews_path
        @types.each do |type|
          page.should_not have_content("#{type} (0)")
        end
      end
    end
  end

  context "given" do
    it_behaves_like "pagination" do
      before(:all){  @type = 'given' }
      before{ @reviews = FactoryGirl.create_list(:review, 15, :user => @current_user) }
    end
  end

  context "received" do
    context "show in widget" do
      before do
        @received_reviews = FactoryGirl.create_list(:review, 2, :rated_company => @current_user.company)
      end

      it "should allows to change flag" do
        Subscription.any_instance.stub(:widget?).and_return { true }
        visit reviews_path
        find("#public_review_#{@received_reviews.first.id}").click
        visit reviews_path
        all('table#reviews input[checked=checked]').size.should eq(1)
      end

      it "should has widget column if subscription has feature", :js => false do
        Subscription.any_instance.stub(:widget?).and_return { true }
        visit reviews_path
        page.should have_css('table#reviews th.widget')
      end

      it "should not has widget column if no subscription feature", :js => false do
        Subscription.any_instance.stub(:widget?).and_return { false }
        visit reviews_path
        page.should_not have_css('table#reviews th.widget')
      end
    end

    context "admin comment", :js => true do
      before do
        @review = FactoryGirl.create(:review, :rated_company => @current_user.company)
        visit reviews_path
      end

      shared_examples_for "a comment was left" do
        it "should behave as exist comment" do
          wait_for_ajax do
            find('#exist_admin_comment_section').should be_visible
            page.should have_content(@review.reload.admin_comment)
            find('#edit_admin_comment').should be_visible
            find('#admin_comment_form').should_not be_visible
          end

          find('#edit_admin_comment').click
          find('#edit_admin_comment').should_not be_visible
          find('#exist_admin_comment_section').should_not be_visible
          find('#admin_comment_form').should be_visible
        end
      end

      it "should validate form" do
        find('.icon.comment').click
        find('#admin_comment_submit').click
        wait_for_ajax { page.should have_selector('.error') }

        within('#admin_comment_form') { fill_in 'review_admin_comment', :with => '1'*1001 }
        find('#admin_comment_submit').click

        wait_for_ajax do
          page.should_have_selector('.error')
          find('#exist_admin_comment_section').should_not be_visible
          find('#edit_admin_comment').should be_visible
        end

        within('#admin_comment_form') { fill_in 'review_admin_comment', :with => '1'*999 }
        find('#admin_comment_submit').click
        page.should_not have_selector('.error')
      end

      context "should show a comment" do
        before do
          @review.update_attribute(:admin_comment, 'Thank you! You are the best customer!')
          find('.icon.details').click
        end

        it_behaves_like "a comment was left"
      end

      context "should left a comment successfully " do
        before do
          find('.icon.comment').click
          within('#admin_comment_form') do
            fill_in 'review_admin_comment', :with => 'Thank you! You are the best customer!'
          end
          find('#admin_comment_submit').click
        end

        it_behaves_like "a comment was left"
      end
    end

    it_behaves_like "pagination" do
      before(:all){  @type = 'received' }
      before{ @reviews = FactoryGirl.create_list(:review, 15, :rated_company => @current_user.company) }
    end

    context "removal request" do
      before do
        @review = FactoryGirl.create(:review, :rated_company => @current_user.company)
        visit reviews_path
      end

      it "should render error when reason missing" do
        find('a.icon.flag').click

        within('#removal_request') do
          click_on('Send request')
          page.should have_content("can't be blank")
        end
      end

      it "should mark review as under investigation" do
        find('a.icon.flag').click

        within('#removal_request') do
          fill_in('review_removal_reason', :with => 'pls delete me')
          click_on('Send request')
          wait_for_ajax
        end

        page.should have_css('#reviews tr.removal_requested')
        @review.reload.should be_removal_requested
      end

      it "should should reviews under investigations crosslined", :js => false do
        should_not have_css('table#reviews tr.removal_requested')
        FactoryGirl.create(:review, :rated_company => @current_user.company, :removal_reason => 'pls delete me', :removal_requested => true)
        visit reviews_path
        page.should have_css('#reviews tr.removal_requested')
      end
    end
  end

  context "pending" do
    it "resends invitation", :js => true do
      customer = FactoryGirl.create :customer, :email => 'new-customer@mail.com', :invited_by => @current_user

      visit reviews_path(:type => 'pending')

      within "#customer_#{customer.id}" do
        click_link 'Resend invitation'
        wait_for_ajax
        page.should have_content('Invitation was resent')
      end

      customer.reload.resent_invitations_count.should == 1
    end

    it "should not allow to resent invitations over which resend limit" do
      customer = FactoryGirl.create :customer, :email => 'new-customer@mail.com', :invited_by => @current_user, :resent_invitations_count => Settings.customer.resend_invitation_limit

      visit reviews_path(:type => 'pending')

      within "#customer_#{customer.id}" do
        page.should have_content('Invitation was resent')
      end
    end

    it "resends all invitations", :js => true do
      CustomerMailer.should_receive(:delay).exactly(3).times.and_return do
        mock_model('Memail').tap { |m| m.should_receive :welcome_message }
      end

      FactoryGirl.create_list :customer, 3, :invited_by => @current_user
      FactoryGirl.create_list :customer, 2, :invited_by => @current_user, :resent_invitations_count => Settings.customer.resend_invitation_limit

      visit reviews_path(:type => 'pending')
      click_on('Resend all')
      within('#confirm_dialog') do
        click_on('Ok')
      end

      page.should have_content('All invitations has been re-sent')
    end

    it_behaves_like "pagination" do
      before(:all){  @type = 'pending' }
      before{ @reviews = FactoryGirl.create_list :customer, 15, :invited_by => @current_user }
    end
  end

  context "filters" do
    before { @review = FactoryGirl.create(:review, :rated_company => @current_user.company, :created_at => 2.years.ago) }

    it_behaves_like "pagination" do
      before(:all) do
        @type = 'received'
        @filters = true
      end

      before do
        @reviews = FactoryGirl.create_list(:review, 14, :rated_company => @current_user.company)
        visit reviews_path(:type => @type)
        find("#toggle_filters").click
        select 'Last year', :from => 'Date'
        find("#filters_submit").click
      end
    end

    it "should sort filtered reviews" do
      min_date = 2.years.ago
      review_with_min_rate = FactoryGirl.create(:review, :rated_company => @current_user.company)
      review_with_min_rate.update_attribute(:rate, 1.2)

      visit reviews_path(:type => @type)
      find("#toggle_filters").click
      find("#filters_submit").click

      find("th.rate > a").click
      page.should have_css('.button_order.ui-state-focus[data-order-field=rate]')
      find('tr.odd > td').should have_content(min_date.strftime("%d.%m.%Y"))

      find("th.date > a").click
      page.should have_css('.button_order.ui-state-focus[data-order-field=created_at]')
      find('tr.odd > td').should_not have_content(min_date.strftime("%d.%m.%Y"))
    end

    it "should reset results clicking by reset" do
      FactoryGirl.create(:review, :rated_company => @current_user.company)
      visit reviews_path(:type => @type)
      find("#toggle_filters").click
      select 'Last year', :from => 'Date'
      find("#filters_submit").click
      find("#clear_filters").click
      wait_for_ajax{ (all("tr.odd").count + all("tr.even").count).should == Review.all.count }
    end
  end
end
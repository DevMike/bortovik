require 'spec_helper'
require 'requests/shared_examples/char_counter'

describe "Ratings" do

  before(:each) do
    @rate_category = FactoryGirl.create(:default_rate_category)
    FactoryGirl.create(:rate_criteria_quality, :rate_criteria_category => @rate_category)
    FactoryGirl.create(:rate_criteria_reliability, :rate_criteria_category => @rate_category)

    @new_review_attributes = FactoryGirl.attributes_for(:review)
    @new_rating_attributes = FactoryGirl.attributes_for(:rating)
    @new_user_attributes   = FactoryGirl.attributes_for(:reviewer)

    company = FactoryGirl.create(:company, :rate_criteria_category => @rate_category)
    user = FactoryGirl.create(:user, :company => company)
    @customer = FactoryGirl.create(:customer, :invited_by => user)
  end

  context "form" do
    it "should display not applicable checkbox if more then one rating" do
      rate_category = FactoryGirl.create(:default_rate_category)
      FactoryGirl.create(:rate_criteria_quality, :rate_criteria_category => rate_category)

      company = FactoryGirl.create(:company, :rate_criteria_category => rate_category)
      user = FactoryGirl.create(:user, :company => company)
      customer = FactoryGirl.create(:customer, :invited_by => user)


      visit(new_rating_path(:token => customer.token))
      page.should_not have_css('.rating_not_applicable')

      FactoryGirl.create(:rate_criteria_quality, :rate_criteria_category => rate_category)
      visit(new_rating_path(:token => customer.token))
      page.should have_css('.rating_not_applicable')
    end

    it "should set remote ip", :js => true do
      visit(new_rating_path(:token => @customer.token))
      find('form#new_review input[name="review[user_ip]"]').value.should match(/\d+\.\d+\.\d+\.\d+/)
    end
  end

  context "as invited customer without account" do

    before(:each) do
      visit(new_rating_path(:token => @customer.token))
    end

    context "consumer" do

      before(:each) do
        choose('Consumer')
      end

      context "presentational logic for new review form" do

        it_behaves_like "char counter" do
          before(:all) do
            @form_selector = "#new_review"
            @field = "review_summary"
            @char_limit = 1000
            @new_description = '1'*1001
            @submit = 'Submit rating'
          end
        end

        it "user email should be disabled" do
          find('#review_user_attributes_email')['readonly'].should == 'readonly'
        end

        context "translate rate criteria attributes" do

          it "name, tooltip should be translated" do
            page.should have_content('Quality of consulting')
            #page.should have_content('Quality of consulting tooltip')
          end

          it "should be fallbacks" do
            page.should have_content('Liefertreue')
          end
        end
      end

      context "submit review" do
        it "should create review with valid data", :js => true do
          fill_in_review_form
          click_button('Submit rating')
          page.should have_content("Thank you for rating the company #{@customer.company.name}. You will receive email with your account information.")
        end

        it "should display errors for required fields" do
          click_button('Submit rating')
          all('.error').count.should eq(3)
        end

        it "should not show required error for not applicable criteria" do
          check('Not applicable')
          click_button('Submit rating')
          all('.error').count.should eq(2)
        end

        it "should allow to set criteria as not applicable", :js => true do
          fill_in_review_form
          check('Not applicable')
          click_button('Submit rating')

          review = Review.last
          review.ratings.count.should == @rate_category.rate_criterias.count
          review.ratings.applicable.count.should == @rate_category.rate_criterias.count - 1
        end
      end
    end

    context "business" do

      before(:each) do
        choose('Business')
      end

      context "submit review" do
        it "should create review with valid data", :js => true do
          fill_in_review_form
          fill_in_attributes("review[user_attributes][%{field}]", @new_user_attributes, :company_name)
          click_button('Submit rating')
          page.should have_content("Thank you for rating the company #{@customer.company.name}. You will receive email with your account information.")
        end

        it "should display errors for required fields" do
          click_button('Submit rating')
          all('.error').count.should eq(6)
        end

        it "should not display error if company exists", :js => true do
          company = FactoryGirl.create(:company)
          @new_user_attributes[:company_name] = company.name

          fill_in_review_form
          fill_in_attributes("review[user_attributes][%{field}]", @new_user_attributes, :company_name)

          click_button('Submit rating')
          page.should have_content("Thank you for rating the company #{@customer.company.name}. You will receive email with your account information.")
        end
      end

    end
  end

  context "as invited customer with existing account" do
    before(:each) do
      @user = FactoryGirl.create(:user, :email => @customer.email)
      visit(new_rating_path(:token => @customer.token))
    end

    it "should recognize customer" do
      page.should have_css('section.criteria')
      page.should_not have_css('#review_user_attributes_email')
    end
  end

  context "direct visitor" do
    before(:each) do
      @company = FactoryGirl.create(:company)
      visit(new_rating_permalink_path(:company_short_name => @company.short_name.downcase))
    end

    it "should recognize rated company by case insensitive slug", :js => true do
      within('.company-details') do
        page.should have_content(@company.name)
        page.should have_content(@company.street)
        page.should have_content(@company.postal_code)
        page.should have_content(@company.city)
      end
    end
  end

  def fill_in_review_form
    within("#new_review") do
      choose('Mr.')

      # temporary removed field
      #fill_in_attributes("review_%{field}", @new_review_attributes, [:summary, :product_service])
      #select('Within the last week', :from => 'Contacted at')

      fill_in_attributes("review_%{field}", @new_review_attributes, [:summary])

      RateCriteria.all.each_with_index do |criteria, index|
        fill_in("review[ratings_attributes][#{index}][comment]", :with => @new_rating_attributes[:comment])
        find("#rate_criteria_#{criteria.id}-#{@new_rating_attributes[:rate].round}").click
      end

      fill_in_attributes("review[user_attributes][%{field}]", @new_user_attributes, [:first_name, :last_name])

      check('review_recommended')
      check('review_tos_confirmation')
    end
  end

end
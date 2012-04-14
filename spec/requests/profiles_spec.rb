require 'spec_helper'

describe "Public profile" do
  before do
    @company = FactoryGirl.create(:company)
  end

  context "common" do
    it "should accessible by public url" do
      visit profile_path(:id => @company.slug)
      page.should have_content(@company.name)
    end

    it "should display not found for company with not filled profile" do
      company = FactoryGirl.create(:just_registered_company)
      visit profile_path(:id => company.slug)
      page.should have_content('Profile Not Found')
    end

    it "should display message for company with not filled profile if previewed" do
      company = FactoryGirl.create(:just_registered_company)
      user    = FactoryGirl.create(:user, :company => company)

      login_as(user)

      visit profile_path(:id => company.slug)
      page.should have_content('You need to complete company profile first')
    end
  end

  context "facts" do
    it "should display categories block with categories assigned" do
      @company.categories = FactoryGirl.create_list(:sequence_category, 3)
      visit profile_path(:id => @company.slug)
      page.should have_selector(".section.categories .category", :count => 3)
    end

    it "should display representatives" do
      @company.users +=  FactoryGirl.create_list(:member, 3, { :company => @company, :representative => true })
      visit profile_path(:id => @company.slug)
      page.should have_selector(".section.representatives .user", :count => 3)
    end
    
    it "should display title if present" do
      @company.users <<  FactoryGirl.create(:member, :company => @company, :representative => true, :title => 'test user title' )
      visit profile_path(:id => @company.slug)
      page.should have_content("test user title")
    end
  end

  context "references" do
    context "with references" do
      it "displays reference" do
        FactoryGirl.create(:review, :rated_company => @company, :summary => 'first review')

        visit reviews_profile_path(:id => @company.slug)

        page.should have_selector('div.review div.summary', :text => 'first review', :visible => true)
      end

      it "displays all references on the first page" do
        FactoryGirl.create_list(:review, Settings.pagination.reviews.list, { :rated_company => @company })

        visit reviews_profile_path(:id => @company.slug)

        page.should_not have_css('a.next_page')
      end

      it "displays two pages when enough reviews to fill the second page" do
        FactoryGirl.create_list(:review, Settings.pagination.reviews.list * 2, { :rated_company => @company })

        visit reviews_profile_path(:id => @company.slug)

        page.should have_css('a.next_page')
        page.should have_selector('div.review div.summary', :count => Settings.pagination.reviews.list)
      end
    end

    context "rate criteria" do
      it "should not display not applicable" do

        review = FactoryGirl.create(:review, :rated_company => @company )
        rate_criteria = FactoryGirl.create(:rate_criteria, :rate_criteria_category => @company.rate_criteria_category)
        not_applicable_rating = FactoryGirl.create(:rating, :review => review, :rate_criteria => rate_criteria, :not_applicable => true)
        applicable_rating = FactoryGirl.create(:rating, :review => review, :rate_criteria => rate_criteria, :not_applicable => false)

        visit profile_path(:id => @company.slug)
        click_on('References')

        all(".rating").count.should == 2
      end
    end
  end

  #context "certificate" do
  #  pending "should show seal for paid user" do
  #    Subscription.any_instance.stub(:paid_plan?).and_return{true}
  #    visit profile_path(:id => @company.slug)
  #    page.should have_css('.sertificate .signature')
  #  end
  #
  #  it "should not show seal for free user" do
  #    Subscription.any_instance.stub(:paid_plan?).and_return{false}
  #    visit profile_path(:id => @company.slug)
  #    page.should_not have_css('.sertificate .signature')
  #  end
  #end

  context "imprint" do
    it "opens external link if imprint type is link" do
      company = FactoryGirl.create(:company, :imprint_type => 'url', :imprint_url => 'http://domain.com')
      visit profile_path(:id => company.slug)
      within('.imprint') do
        page.should have_css("a[href='http://domain.com']")
        page.should_not have_css('#show_imprint')
      end
    end

    it "opens dialog if imprint type is text", :js => true do
      company = FactoryGirl.create(:company, :imprint_type => 'text', :imprint_text => 'some imprint text', :imprint_url => 'http://domain.com')
      visit profile_path(:id => company.slug)

      find('#imprint_dialog').should_not be_visible

      within('.imprint') do
        page.should_not have_css("a[href='http://domain.com']")
        click_on('Show')
      end

      find('#imprint_dialog').should be_visible

      page.should have_content('some imprint text')
    end
  end

  context "individual profile path", :js => true do
    it "profile tab should be active" do
      visit profile_url(@company.slug, 'profil')
      page.should have_css('a', :href=> "#details", :class => "active")
    end
  end

  context "redirect for profile urls with status 301" do
    it "direct profile url" do
      visit "/profile/#{@company.slug}"
      current_url.should include("/profil/#{@company.slug}")
    end
  end

  context "description" do
    it "should display found urls as links" do
      company = FactoryGirl.create(:company, :raw_description => '<p>Our site is geprueft.de(or www.geprueft.de or http://geprueft.de or http://www.geprueft.de!</p><p>But we also like google.com or google.com/some.html or http://google.com/some.html</p>http://geprueft.de is the best company catalogue! Test link <a href="http:// salesworker.com">link</a>')
      visit profile_path(:id => company.slug)
      page.should have_css('a', :rel => "nofollow", :href => 'http://geprueft.de',          :text => 'geprueft.de')
      page.should have_css('a', :rel => "nofollow", :href => 'http://geprueft.de',          :text => 'http://geprueft.de')
      page.should have_css('a', :rel => "nofollow", :href => 'http://www.geprueft.de',      :text => 'http://www.geprueft.de')
      page.should have_css('a', :rel => "nofollow", :href => 'http://www.geprueft.de',      :text => 'www.geprueft.de')
      page.should have_css('a', :rel => "nofollow", :href => 'http://google.com',           :text => 'google.com')
      page.should have_css('a', :rel => "nofollow", :href => 'http://google.com/some.html', :text => 'google.com/some.html')
      page.should have_css('a', :rel => "nofollow", :href => 'http://google.com/some.html', :text => 'http://google.com/some.html')
      page.should have_css('a', :rel => "nofollow", :href => 'http://salesworker.com',      :text => 'link')
    end

    it "should display only url as link" do
      company = FactoryGirl.create(:company, :raw_description => 'geprueft.de')
      visit profile_path(:id => company.slug)
      page.should have_css('a', :rel => "nofollow", :href => 'http://geprueft.de',          :text => 'geprueft.de')
    end

    it "should display lists correctly" do
      company = FactoryGirl.create(:company, :raw_description => '<ul><li>test</li><li>test2</li></ul>')
      visit profile_path(:id => company.slug)
      page.should have_css('li', :text => 'test')
      page.should have_css('li', :text => 'test2')
    end

    it "should display mails as links with mailto" do
      company = FactoryGirl.create(:company, :raw_description => ' <a href="mailto:some@geprueft.de">some@geprueft.de</a>')
      visit profile_path(:id => company.slug)
      page.should have_css('a', :rel => "nofollow", :href => 'mailto:some@geprueft.de', :text => 'some@geprueft.de')
    end

    it "should disallow user credentials" do
      company = FactoryGirl.create(:company, :raw_description => 'Credentials which break IE7 username:password@domain.url')
      visit profile_path(:id => company.slug)
      page.should_not have_content('username:password@domain.url')
    end
  end

  context "phone number" do
    it "should display virtual number if exists" do
      company = FactoryGirl.create(:company, :virtual_phone => '44-44-44', :phone => '55-55-55')
      visit profile_path(:id => company.slug)
      page.should have_content('44-44-44')
    end

    it "should be displayed in profile" do
      company = FactoryGirl.create(:company, :phone => '55-55-55')
      visit profile_path(:id => company.slug)
      page.should have_content(company.phone)
    end
  end

  context "PushToAction" do
    before do
      @company = FactoryGirl.create :company, :use_push_to_action => true,
                                              :push_to_action_text => 'Please visit our official site',
                                              :push_to_action_url => 'http://example.com'
    end

    it "should be visible if enabled" do
      visit profile_path(:id => @company.slug)
      find('.push_to_action').should be_visible
      page.should have_css('input', :type => "submit", :value => @company.push_to_action_text)
    end

    it "should open link in new window" do
      visit profile_path(:id => @company.slug)
      page.should have_css('form', :target => "_blank", :action => @company.push_to_action_url, :method => 'get')
    end
  end

  context "meta tags" do
    context "meta keywords" do
      it "should display meta keywords if they are" do
        meta_keywords = 'corporations, business'
        company = FactoryGirl.create(:company, :meta_keywords => meta_keywords)
        visit profile_path(:id => company.slug)
        find("meta[name='keywords']")['content'].should == meta_keywords
      end

      it "should display categories as keywords if there is no meta description" do
        company = FactoryGirl.create(:company)
        company.categories = FactoryGirl.create_list(:sequence_category, 2)
        categories = []
        company.categories.each{ |category| categories << category.name }
        visit profile_path(:id => company.slug)

        find("meta[name='keywords']")['content'].should == categories.join(', ')
      end
    end
  end

  context "links to paginated reviews" do
    before do
      FactoryGirl.create_list(:review, 2 * Settings.pagination.reviews.list, { :rated_company => @company })
    end

    it "should be placed on overview page" do
      visit profile_path(:id => @company.slug)
      page.should have_selector("a.logo")
    end

    it "should not be placed on paginade page" do
      visit reviews_profile_path(:id => @company.slug)
      page.should_not have_selector("a.logo")
    end

    it "should reference to paginated reviews" do
      visit profile_path(:id => @company.slug)
      find("a.logo").click
      page.should have_content(@company.name)
      page.should_not have_selector("a.logo")
    end

    it "should not break pagination index when review was deleted" do
      @company.received_reviews.latest.last.destroy
      visit reviews_profile_path(:id => @company.slug) + '/seite/1-10'
      all('.review').count.should == Settings.pagination.reviews.list - 1
    end
  end
end
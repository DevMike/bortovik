# encoding: UTF-8
require 'spec_helper'

describe "Home" do
  context "follow a permalink" do
    before { visit root_path }

    context "with redirect" do
      it "should have content with" do
        company = FactoryGirl.create(:user).company
        fill_in 'pin', :with => company.short_name
        find('#to_ratings_form input[type=submit]').click
        page.should have_content("Rate #{company.name}")
      end

      it "should redirects to info page when company wasn't entered" do
        fill_in 'pin', :with => 'wrong'
        find('#to_ratings_form input[type=submit]').click
        page.should have_content("Company not found")
      end
    end

    context "without redirect", :js => true do
      it "should redirects to info page when company wasn't entered" do
        find('#to_ratings_form input[type=submit]').click
        page.should have_content(I18n.t(:'home.home.rating_form.not_filled_pin_message'))
      end
    end
  end

  context "search bar", :js => true do
    before {
      @category = FactoryGirl.create(:content_category)
      visit root_path
      find('#search_toggle').click
    }

    it "should show search bar on search button click" do
      find('#search_bar').should be_visible
    end

    it "should have a category in search bar" do
      find('#search_bar').find('.root-category:first').should have_content(@category.name)
    end

    it "should show search bar form" do
      within('#search_bar') do
        find('.tabs-panel').find('.tab:last').click
        find('#content_search').should be_visible
      end
    end

    it "should redirect to company if valid company name filled" do
      within('#search_bar') do
        find('.tabs-panel').find('.tab:last').click
        within('#content_search') do
          fill_in('category_name', :with => @category.name)
          find('input[@name=commit]').click
        end
      end
      wait_for_ajax do
        current_url.should include(content_path(@category))
      end
    end
  end

  context "contact message" do
    before { visit contact_path }
    before(:all) {
      @contact_message_attributes = FactoryGirl.attributes_for(:contact_message)
      @not_inputs = [:question]
      @user_attributes = [:companies_name, :email, :mobile_phone, :name]
    }

    context "signed in" do
      sign_in(:user_another)

      it "user data should be filled" do
        visit contact_path
        @user_attributes.each do |attr|
          find("#contact_message_#{attr.to_s}")['value'].should eq(@current_user.send(attr))
        end
      end

      it "user data should be readonly" do
        visit contact_path
        @user_attributes.each do |attr|
          find("#contact_message_#{attr}")['readonly'].should == 'readonly'
        end
      end

      it "non-required fields should not be disabled when they absent" do
        @current_user.update_attribute(:mobile_phone, '')
        visit contact_path
        find("#contact_message_mobile_phone")['readonly'].should_not == 'readonly'
      end
    end

    context "signed in consumer" do
      sign_in(:consumer)
      it "should open the page" do
        visit contact_path
        find("#contact_message_companies_name")['value'].should be_nil
      end
    end

    context "not signed in" do
      it "user attributes should not be readonly" do
        @user_attributes.each do |attr|
          find("#contact_message_#{attr}")['readonly'].should_not == 'readonly'
        end
      end
    end

    context "success" do
      it "should send and show a message" do
        within('#new_contact_message') do
          @contact_message_attributes.reject{|m| @not_inputs.include?(m)}.each_key do |key|
            fill_in "contact_message_#{key}", :with => @contact_message_attributes[key]
          end
        end
        find('input[@name=commit]').click
        page.should have_content(I18n.t(:'marketing.greetings'))
      end
    end

    context "errors" do
      it "should display errors and show a message" do
        within('#new_contact_message') do
          @contact_message_attributes.reject{|m| @not_inputs.include?(m)}.each_key do |key|
            fill_in "contact_message_#{key}", :with => ''
          end
        end
        find('input[@name=commit]').click

        all('.error').count.should eq(6)
        page.should have_content(I18n.t(:'marketing.errors'))
      end

      it "should keep values" do
        within('#new_contact_message') do
          @contact_message_attributes.reject{|m| @not_inputs.include?(m) || m == :mobile_phone}.each do |key,value|
            fill_in "contact_message_#{key}", :with => value
          end
        end
        find('input[@name=commit]').click
        @contact_message_attributes.reject{|m| @not_inputs.include?(m) || m == :mobile_phone}.each do |key,value|
          find("#contact_message_#{key}")['value'].should == value
        end
      end
    end
  end

  context "newsletter form", :js => true do
    before { visit for_company_path }

    it "should have errors when email is invalid" do
      within('#newsletter') do
        fill_in 'MERGE0', :with => 'wrong'
      end
      find('input[@name=commit]').click
      click_on 'Jetzt anmelden!'

      find(".error", :text => 'E-Mail ist ungültig').should be_visible
    end

    it "should redirects to newsletter form" do
      within('#newsletter') do
        fill_in 'MERGE0', :with => 'correct@gmail.com'
      end
      click_on 'Jetzt anmelden!'

      current_url.should eq('http://salesworker.us2.list-manage.com/subscribe/post')
    end
  end
end
require 'spec_helper'

describe "Feedbacks", :js => true do
  context "list" do
    sign_in(:user)
    it "should open popup dialog with feedback details" do
      feedback = FactoryGirl.create(:feedback, :company => @current_user.company)

      visit feedbacks_path

      find('a.icon.details').click

      within('#dialog') do
        page.should have_content(feedback.name)
      end
    end
  end

  context "visibility" do
    before do
      @company = FactoryGirl.create(:user).company
    end

    it "should be rendered if enabled in company profile" do
      @company.update_attribute(:use_feedback_form, true)
      visit profile_path(:id => @company.slug)
      find('#new_feedback').should be_visible
    end

    it "should not be rendered if disabled enabled in company profile" do
      @company.update_attribute(:use_feedback_form, false)
      visit profile_path(:id => @company.slug)
      page.should_not have_selector('#feedback_wrapper')
    end

  end


  context "create" do

    before :each do
      @company = FactoryGirl.create(:user).company
      visit profile_path(:id => @company.slug)
      @feedback_data = {
        :name => Faker::Name.name,
        :email => Faker::Internet.email,
        :phone => Faker::PhoneNumber.phone_number[0...20],
        :message => Faker::Lorem.paragraph(3)
      }
    end

    it "should be titled with company custom headline if present" do
      custom_headline = 'Test contact headline'
      @company.update_attributes!(:use_default_headline => false, :contact_headline => custom_headline)
      visit profile_path(:id => @company.slug)
      page.should have_content(custom_headline)
    end

    it "should be titled with default headline if custom headline disabled" do
      visit profile_path(:id => @company.slug)
      page.should have_content(I18n.t('profiles.details.call_us'))
    end

    %w(name email phone message).each do |field|
      it "field #{field} should be visible" do
        find("#new_feedback #feedback_#{field}").should be_visible
      end
    end


    it "antispam field should be hidden" do
      find("#new_feedback #feedback_email_confirmation").should_not be_visible
    end

    it "form_token should be filled" do
      find("#new_feedback #form_token").value.should_not be_empty
    end


    it "should save feedback if form filled correctly" do
      @feedback_data.each_pair do |field_name, field_value|
        fill_in "feedback_#{field_name}", :with => field_value
      end
      Settings.stub_chain(:global, :spam_protection_timeout).and_return(0)

      click_on("Send")

      page.should have_content(I18n.t(:'feedbacks.notice.created'))
    end

    it "should reject sending if form filled faster then 2 seconds" do
      @feedback_data.each_pair do |field_name, field_value|
        fill_in "feedback_#{field_name}", :with => field_value
      end
      Settings.stub_chain(:global, :spam_protection_timeout).and_return(20)
      click_on("Send")
      page.should have_content(I18n.t(:'feedbacks.notice.has_error'))
    end

    it "should reject sending if fake field filled" do
      @feedback_data.each_pair do |field_name, field_value|
        fill_in "feedback_#{field_name}", :with => field_value
      end
      # capybara disallow set values for invisible elements
      page.evaluate_script("document.getElementById('feedback_email_confirmation').value = '#{@feedback_data[:email]}';")
      # wait for antispam check
      Settings.stub_chain(:global, :spam_protection_timeout).and_return(0)
      click_on("Send")
      page.should have_content(I18n.t(:'feedbacks.notice.has_error'))
    end
  end
end
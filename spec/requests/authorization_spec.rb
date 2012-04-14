require 'spec_helper'

describe "Authorization" do

  context "Access" do

    shared_examples_for "team member abilities" do
      it "should be able to use filters" do
        visit reviews_path
        page.should have_selector("#review_type")
      end

      it "should display team link" do
        visit dashboard_path
        page.should have_css("a[href='#{users_path}']")
      end

      it "should display dashboard link" do
        visit dashboard_path
        page.should have_css(".dashboard", :text => "Dashboard")
      end

      it "should not display additional user fields" do
        visit edit_user_registration_path
        page.should have_selector("#user_timezone")
        page.should have_selector("#user_title")
        page.should have_selector("#user_mobile_phone")
        page.should have_selector("#user_office_phone")
        page.should have_selector("#user_fax")
      end

      it "should view team page" do
        should_not_raise_access_denied{ visit users_path }
      end
    end

    context "admin" do
      sign_in(:user)
# feature disabled
=begin
      it "can edit only his users" do
        user_another = FactoryGirl.create(:user_another)
        should_raise_access_denied {visit edit_user_path(user_another)}
      end
=end
      it "should has access to invitation page" do
        visit new_user_invitation_path
        page.should have_content('Invite a new team member')
      end

      it_should_behave_like "team member abilities"
    end

# feature disabled
=begin
    context "member" do
      sign_in(:member)

      it "cannot edit company profile" do
        should_not_edit_company_profile
      end

      it "should hasn't access to invitation page" do
        should_raise_access_denied{ visit new_user_invitation_path }
      end

      it_should_behave_like "team member abilities"
    end
=end

    context "consumer" do
      sign_in(:consumer)

      it "cannot edit company profile" do
        should_not_edit_company_profile
      end

      it "should hasn't access to invitation page" do
        should_raise_access_denied{ visit new_user_invitation_path }
      end

      it "should not display notifications" do
        visit root_path
        page.should_not have_selector(".notification")
      end

      it "should not be able to use filters" do
        visit root_path
        page.should_not have_selector("#review_type")
      end

      it "should not display team link" do
        visit root_path
        page.should_not have_css("a[href='#{users_path}']")
      end

      it "should not display dashboard link" do
        visit root_path
        page.should_not have_css(".dashboard", :text => "Dashboard")
      end

      it "should not display additional user fields" do
        visit edit_user_registration_path
        page.should_not have_selector("#user_timezone")
        page.should_not have_selector("#user_title")
        page.should_not have_selector("#user_mobile_phone")
        page.should_not have_selector("#user_office_phone")
        page.should_not have_selector("#user_fax")
      end

      it "should not view account page" do
        should_raise_access_denied{ visit company_path }
      end

      it "should not view team page" do
        should_raise_access_denied{ visit users_path }
      end

      it "should not display account link" do
        visit dashboard_path
        page.should_not have_selector("a.account")
      end
    end
  end
end


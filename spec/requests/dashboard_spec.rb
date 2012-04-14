require 'spec_helper'

describe "Dashboard" do
  context "getting started" do
    sign_in(:user)

    before(:each) do
      company = @current_user.company
      company.getting_started.delete_if { true }
      company.save
    end

    def add_to_getting_started_set(attribute)
      company = @current_user.company
      company.getting_started.add(attribute)
      company.save
      visit dashboard_path
    end

    context "user" do
      it "should display getting started section by default" do
        visit dashboard_path
        page.should have_selector('.help-steps')
      end

      it "blank slate attributes should not be checked" do
        visit dashboard_path
        page.should_not have_selector("dl.steps > dl.steps > dt.check")
      end

      it "invite to rate should be checked" do
        add_to_getting_started_set(:invite_to_rate)
        page.should have_selector("dl.invite-to-rate > dt.check")
      end

      it "invites members should be checked" do
        add_to_getting_started_set(:invite_members)
        page.should have_selector("dl.invite-members > dt.check")
      end

      it "fill out company profile should be checked" do
        add_to_getting_started_set(:fill_out_company_profile)
        page.should have_selector("dl.fill-out-company-profile > dt.check")
      end

      it "getting started section should be hided" do
        user = @current_user
        user.getting_started.add(:hide)
        user.save!
        visit dashboard_path
        page.should_not have_selector('.help-steps')
      end

      it "should hiding getting started", :js => true do
        visit dashboard_path
        click_link "Click to remove this list"
        page.should_not have_selector('.help-steps')
      end
    end

    #pending "customer" do
    #  #TODO: implement tests for user set when it will be enabled(attributes:   :look_at_submitted_ratings, :filled_profile). @Mike
    #end
  end
end

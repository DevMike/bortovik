require 'spec_helper'

shared_examples_for "upgrade link visible" do
  it "should display link to upgrade" do
    page.should have_css("a[href='#{company_path}']", :text => 'Upgrade account')
  end
end

shared_examples_for "upgrade link invisible" do
  it "should not display link to upgrade" do
    page.should_not have_css("a[href='#{company_path}']", :text => 'Upgrade account')
  end
end

shared_examples_for "upgrade link conditional visibility" do
  it "should be visible depend on condition" do
    if @available_method == :invitations_per_month_available?
      page.should have_css("a[href='#{company_path}']", :text => 'Upgrade account')
    else
      page.should_not have_css("a[href='#{company_path}']", :text => 'Upgrade account')
    end
  end
end

shared_examples_for "term restrictions" do
  context "admin" do
    before { User.any_instance.stub(:admin?).and_return{ true } }

    context "invitations unavailable" do
      before do
        Subscription.any_instance.stub(@available_method).and_return{ false }
        visit new_customer_path
      end

      it_behaves_like "upgrade link conditional visibility"
    end

    context "invitations during the sending" do
      before do
        Subscription.any_instance.stub(@used_invitation_type).and_return{ @invitations_limit - 1 }
        visit new_customer_path
        fill_in "Email", :with => 'new-customer@mail.com,asd@.lk;test, test@test.test'
        click_on "Send invitation"
      end

      it_behaves_like "upgrade link conditional visibility"
    end
  end

  context "member" do
    before { User.any_instance.stub(:admin?).and_return{ false } }

    context "invitations unavailable" do
      before do
        Subscription.any_instance.stub(@available_method).and_return{ false }
        visit new_customer_path
      end

      it_behaves_like "upgrade link invisible"
    end

    context "invitations during the sending" do
      before do
        Subscription.any_instance.stub(@used_invitation_type).and_return{ @invitations_limit - 1 }
        visit new_customer_path
        fill_in "Email", :with => 'new-customer@mail.com,asd@.lk;test, test@test.test'
        click_on "Send invitation"
      end

      it_behaves_like "upgrade link invisible"
    end
  end
end

describe "Customers" do
  sign_in(:user)
  before { visit new_customer_path }

  context "successfully" do
    context "mass invite" do
      before do
        visit new_customer_path
        fill_in "Email", :with => 'new-customer@mail.com,asd@.lk;test, test@test.test'
        click_on "Send invitation"
      end

      it "should display correct emails on the verify page" do
        page.should have_content("Invitation to rate will be sent to these emails: new-customer@mail.com test@test.test")
      end

      it "should display info that invitations has been sent" do
        click_on "Send invitation"
        page.should have_content("Invitation to rate your company has been sent to new-customer@mail.com, test@test.test")
      end
    end

    context "single invite" do
      before do
        visit new_customer_path
        fill_in "Email", :with => 'new-customer@mail.com'
      end

      it "should send invitation on single step" do
        expect{ click_on "Send invitation" }.to change(Customer, :count).by(1)
        page.should have_content("Invitation to rate your company has been sent to new-customer@mail.com")
      end
    end
  end

  context "failure" do
    it "should show a message that all emails are wrong" do
      visit new_customer_path
      fill_in "Email", :with => 'new-customer,asd@.;test, @test.test'
      click_on "Send invitation"
      page.should have_content("Stop! All the entered emails are wrong")
    end

    context "displaying link to upgrade that limit will be exceeded" do

      context "per day" do
        before do
          @available_method     = :invitations_per_day_available?
          @used_invitation_type = :invitations_used_per_day
          @invitations_limit    = Settings.subscriptions.silver.invitations_per_day
        end

        it_behaves_like "term restrictions"
      end

       context "per month" do
        before do
          @available_method     = :invitations_per_month_available?
          @used_invitation_type = :invitations_used
          @invitations_limit    = Settings.subscriptions.silver.invitations_per_month
        end

        it_behaves_like "term restrictions"
      end
    end
  end
end

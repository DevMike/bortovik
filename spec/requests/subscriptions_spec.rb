require 'spec_helper'
require 'requests/shared_examples/billing_info'

describe "Subscription" do
  sign_in(:admin)

  context "Account" do
    before { visit company_path }

    shared_examples_for "paid plans" do
      context "account section elements" do
        it "should not sections with filled subscriptions/billing attributes" do
          page.should have_selector('.address')
          page.should have_selector('.billing')
        end

        it "should display column for free paid plan" do
          all('th')[1].should_not have_content('Free')
        end

        it "should display links to subscribe for paid plans that now is not current only" do
          current_plan = @current_user.company.current_subscription.plan_type
          page.should_not have_css("a[href='#{new_subscription_url(:plan => Subscription.plan_options(current_plan)[:name])}']")

          Subscription::PAID_PLANS.reject{|p| p == current_plan }.each do |plan|
            page.should have_css("a[href='#{new_subscription_url(:plan => Subscription.plan_options(plan)[:name])}']")
          end
        end
      end
    end

    context "silver plan" do
      before(:each) do
        FactoryGirl.create(:subscription, :company => @current_user.company)
        visit company_path
      end

      it_behaves_like "paid plans"
    end

    context "gold plan" do
      before(:each) do
        FactoryGirl.create(:subscription_gold, :company => @current_user.company)
        visit company_path
      end

      it_behaves_like "paid plans"
    end
  end

  context "upgrade wizard" do
    before { visit company_path }

    it "displays plan info" do
      Subscription.stub(:plan_options).and_return({ :plan_type => 'gold', :amount_in_cents => 19900 })
      visit new_subscription_path(:plan => 'pro')
      page.should have_content("You're upgrading for the Gold plan")
    end


    it_behaves_like "billing info" do
      before(:all)  { @success_info = "Verify and upgrade" }
      before(:each) { click_on('Subscribe') }
    end


    context "verify and upgrade(integration test)", :js => true do
      it "should have message that account has been updated" do
        click_on('Subscribe')
        check 'Same as customer address'
        choose 'invoice'
        find('input[@name=commit]').click
        check 'I have read, understand and accept the terms and conditions'

        find('input[@name=commit]').click
        page.should have_content('Successfully updated to Gold plan')
      end
    end
  end
end

require 'spec_helper'

describe "Registrations" do
  before { visit new_user_registration_path }

  it "shows form" do
    page.should have_selector('#user_new')
  end

  it "displays paid plan info" do
    Subscription.stub(:plan_options).and_return({ :plan_type => 'silver', :amount_in_cents => 5900 })
    visit new_user_registration_path(:plan => 'basic')
    page.should have_content("You're registering for the Silver plan")
  end

  it "requires all fields" do
    click_button('Sign up')
    should_have_errors_for("#user_new", 4)
  end

  it "should be flash alert when user required fields don't fill in" do
    click_button('Sign up')
    page.should have_content(I18n.t 'flash.actions.update.alert')
  end

  it "shows error for already take address" do
    user = FactoryGirl.create(:user)
    within('#user_new') do
      fill_in 'Email', :with => user.email
    end
    click_button('Sign up')
    should_have_error_for("#user_new .email")
  end

  it "displays discount info", :js => true do
    discount = FactoryGirl.create :discount, :code => 'code', :plan_type => 'gold', :tagline => 'code DE'

    click_on 'Enter it here'
    fill_in 'code', :with => 'code'
    click_button 'Redeem'
    page.should have_content('Confirm to apply for this subscription')

    click_button 'Ok'
    page.should have_content('code DE')
  end

  context "after successful process" do
    it "redirects to confirmation message" do
      fill_in_user_fields

      company = FactoryGirl.attributes_for(:company)

      within('#user_new') do
        fill_in 'Company', :with => company[:name]
      end
      click_button('Sign up')

      page.should have_content('You need to confirm your membership')
    end

    # TODO temporary disabled
    #pending "shows 'request received' message" do
    #  fill_in_user_fields
    #
    #  FactoryGirl.create :company, :name => '42 industries'
    #
    #  within('#user_new') do
    #    fill_in 'Company', :with => '42 industries'
    #  end
    #  click_button('Sign up')
    #
    #  page.should have_content('The administrator for 42 industries has received your request.')
    #  page.should have_content('He has to confirm your request, before you are able to use geprueft.de.')
    #end

    def fill_in_user_fields
      user = FactoryGirl.attributes_for(:user)

      within('#user_new') do
        fill_in 'First name', :with => user[:first_name]
        fill_in 'Last name', :with => user[:last_name]
        fill_in 'Email', :with => user[:email]

        choose 'Mr.'
      end
    end
  end
end

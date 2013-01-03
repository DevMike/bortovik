require 'spec_helper'
include Warden::Test::Helpers
describe "Currency" do
  before(:all) { @default_currency = 'UAH' }
  before { Money.default_currency = @default_currency }

  shared_examples_for "currency switcher" do
    it "should show selected currency as regular text, another ones should show as links" do
      current_path.should == root_path
      page.should_not have_css('a', :text => @selected_currency)
      page.should have_content(@selected_currency)
      unselected_currencies(@selected_currency).each do |currency|
        find('a', :text => currency)[:href].should == root_path(:currency => currency)
      end
    end
  end

  context "default behavior" do
    before do
      @selected_currency = Money.default_currency.to_s
      visit root_path
    end

    it_behaves_like "currency switcher"
  end

  context "switching" do
    before do
      visit root_path
      @selected_currency = 'RUB'
      click_link @selected_currency
    end

    it_behaves_like "currency switcher"
  end

  context "user choice" do
    before(:all) { @selectable_currency = 'RUB' }

    it "should set default_currency depend on user one on sign_in" do
      user = FactoryGirl.create(:user, :preferred_currency => @selectable_currency)
      visit new_user_session_path
      expect {
        fill_in 'user_email', :with => user.email
        fill_in 'user_password', :with => user.password
        submit_form
      }.to change { Money.default_currency.to_s }.from(@default_currency).to(@selectable_currency)
    end

    context "signed in" do
      sign_in(FactoryGirl.create(:user))
      it "should update preferred currency of current user on change" do
        visit root_path
        expect {
          click_link @selectable_currency
        }.to change { Money.default_currency.to_s }.from(@default_currency).to(@selectable_currency)
      end
    end
  end
end

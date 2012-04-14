require 'spec_helper'

describe "CustomerRequest" do
  before do
    @category = FactoryGirl.create(:content_category)
  end

  context "with prospects" do
    before do
      @category.companies << FactoryGirl.create(:prospect, :name => 'Prospect name')
    end

    context "nearest found" do

      before do
        Settings.stub_chain(:customer_request, :zip_lookup_radius).and_return{10000000}
      end

      it "shows prospects list after entering zip code" do
        visit new_customer_request_path(@category.to_param)

        fill_in 'Postcode', :with => '12345'
        click_on 'Send my request'

        page.should have_content('Prospect name')
      end

      it "should shows request form after prospects list with passed prospects" do
        visit new_customer_request_path(@category.to_param, :customer_request => {:postal_code => '12345'})

        click_on 'Request offer'

        within('#new_customer_request') do
          page.find("input[name='company_ids[]']").value == @category.companies.first.id
        end
      end

      it "should show error if no prospects selected" do
        visit new_customer_request_path(@category.to_param, :customer_request => {:postal_code => '12345'})

        uncheck('company_ids_')
        click_on 'Request offer'

        page.should have_content('Please choose at least one prospect')
      end

    end

    context "nearest not found" do
      before do
        Settings.stub_chain(:customer_request, :zip_lookup_radius).and_return{1}
      end

      it "should skip prospects list" do
        visit new_customer_request_path(@category.to_param)

        fill_in 'Postcode', :with => '12345'
        click_on 'Send my request'

        page.should have_css('#new_customer_request')
      end
    end

    context "found requestable" do
      it "should not found when company is not requestable" do
        @category.companies << FactoryGirl.create(:prospect, :name => 'DontWantLeads', :want_leads => false)
        Settings.stub_chain(:customer_request, :zip_lookup_radius).and_return{10000000}

        visit new_customer_request_path(@category.to_param)
        fill_in 'Postcode', :with => '12345'
        click_on 'Send my request'
        page.should_not have_content('DontWantLeads')
      end
    end
  end

  context "without prospects" do
    it "should submit form in single step" do
      visit new_customer_request_path(@category.to_param)

      fill_in 'Product/service', :with => 'Car'
      fill_in 'Description',     :with => 'Need to repair my car'
      fill_in 'Postcode',        :with => '12345'
      fill_in 'Your Name',       :with => 'Will Smith'
      fill_in 'Your Email',      :with => 'will.smith@mail.com'
      fill_in 'Your Phone',      :with => '555-555-555'

      click_on 'Send my request'

      page.should have_content('Your inquiry was successfully sent')
    end
  end

end

require 'spec_helper'

def field_id(field)
  "#"+[@prefix,field].join('_')
end

def field_name(field)
  [@prefix,field].join('_')
end

shared_examples_for "billing info" do

  before(:all) { @prefix = 'billing_info' }

  context "presentational logic", :js => true do
    context "toggle hiding billing address fields" do

      before(:all) { @company_fields = ['postal_code', 'city', 'email', 'company_name', 'address'] }

      context "when not filled yet" do
        it "address fields should be disabled" do
          check('Same as customer address')
          @company_fields.each do |field|
            find("#{field_id(field)}")['readonly'].should eq("true")
          end
          find("#{field_id('country')}")['disabled'].should eq("true")
        end

        it "should be enabled" do
          uncheck('Same as customer address')
          @company_fields.each do |field|
            find("#{field_id(field)}")['readonly'].should_not eq("true")
          end
          find("#{field_id('country')}")['disabled'].should_not eq("true")
        end
      end

      context "toggle submit button" do

        it "should toggle submit button depend on payment method" do
          choose('invoice')
          find('input[@name=commit]')['disabled'].should_not eq("true")

          choose('bank collection')
          find('input[@name=commit]')['disabled'].should eq("true")
        end

        it "should enable submit button clicking by confirmation" do
          choose('bank collection')
          check 'I hereby grant a collection authorization to geprueft.de'
          find('input[@name=commit]')['disabled'].should_not eq("true")
        end
      end

      context "toggle billing fields visibility" do

        it "should toggle visibility depend on payment method" do
          billing_attributes = ['bank_code', 'bank_name', 'account_number', 'account_holder', 'registration_number']

          choose('invoice')
          billing_attributes.each do |attr|
            find(field_id(attr)).should_not be_visible
          end

          choose('bank collection')
          billing_attributes.each do |attr|
            find(field_id(attr)).should be_visible
          end
        end
      end

      context "toggle disabling invoice method depend on country" do
        it "should not be disabled when country is Germany" do
          find(field_id(:payment_method_invoice)).should be_visible
          find("#payment_method_info").should be_visible
          find("#another_country_info").should_not be_visible
        end

        it "should toggle billing behavior depend on country" do
          uncheck('Same as customer address')
          select 'Russia', :from => 'Country'
          find(field_id(:payment_method_invoice)).should_not be_visible
          find("#payment_method_info").should_not be_visible
          find("#another_country_info").should be_visible

          select 'Germany', :from => 'Country'
          find(field_id(:payment_method_invoice)).should be_visible
          find("#payment_method_info").should be_visible
          find("#another_country_info").should_not be_visible
        end
      end
    end
  end

  context "data saving" do
    before(:all) do
      @billing_info_attributes = FactoryGirl.attributes_for(:billing_info)
      @not_fields = [:country, :payment_method, :company_address]
    end

    before {
      uncheck('Same as customer address')
      choose 'bank collection'
    }

    it "should save data when all fields are filled in correct" do
      @billing_info_attributes.reject{|c| @not_fields.include?(c)}.each do |attr, value|
        within('#edit_billing_info') do
          fill_in field_name(attr), :with => @billing_info_attributes[attr]
        end
      end
      select 'Germany', :from => 'Country'
      check 'I hereby grant a collection authorization to geprueft.de'
      find('input[@name=commit]').click
      page.should have_content(@success_info)
    end

    it "should have errors when required fields didn't fill in" do
      @billing_info_attributes.reject{|c| @not_fields.include?(c)}.each do |attr, value|
        within('#edit_billing_info') do
          fill_in field_name(attr), :with => ''
        end
      end
      check 'I hereby grant a collection authorization to geprueft.de'
      find('input[@name=commit]').click
      all('.error').count.should eq(8)
    end

    it "should validate billing fields when bank collection is selected" do
      @billing_info_attributes.reject{|c| @not_fields.include?(c)}.each do |attr, value|
        within('#edit_billing_info') do
          fill_in field_name(attr), :with => ''
        end
      end
      choose 'invoice'
      find('input[@name=commit]').click
      all('.error').count.should eq(5)
    end

    it "billing address values should not saved when 'same as company' is selected", :js => true do
      ['postal_code', 'city', 'email', 'company_name', 'address'].each do |attr|
        within('#edit_billing_info') do
          fill_in field_name(attr), :with => ''
        end
      end
      check('Same as customer address')
      choose 'invoice'
      find('input[@name=commit]').click
      page.should have_content(@success_info)
    end
  end

end
require 'spec_helper'

describe "Registrations" do
  before{ FactoryGirl.create(:default_settlement) }

  it "should validate", js: true do
    visit new_user_registration_path
    all('.error').count.should == 0

    submit_form

    all('.error').count.should == 4
    current_path.should eq(new_user_registration_path)
  end

  context "location dropowns reloading", :js => true do
    it "should refill regions and settlements on change country" do
      settlement = FactoryGirl.create(:settlement)
      other_settlement = FactoryGirl.create(:settlement)
      region_of_same_country = FactoryGirl.create(:region, :country => settlement.region.country)
      settlement_of_same_region = FactoryGirl.create(:settlement, :region => region_of_same_country)

      visit new_user_registration_path

      select other_settlement.region.country.name, :from => 'user_country_id'
      wait_for_ajax
      select settlement.region.country.name, :from => 'user_country_id'
      wait_for_ajax

      find('#user_region_id').should have_content(settlement.region.name)
      find('#user_settlement_id').should have_content(settlement.name)

      select region_of_same_country.name, :from => 'user_region_id'
      wait_for_ajax

      find('#user_settlement_id').should have_content(settlement_of_same_region.name)
    end
  end

  context "form" do
    it "should validate form" do
      visit new_user_registration_path
      submit_form
      all('.error').count.should == 5
    end

    it "should save entered values", :js => true do
      settlement = FactoryGirl.create_list(:settlement, 3).last
      attributes = FactoryGirl.attributes_for(:user)
      inputs = { :text => [:name, :email, :password, :password_confirmation],
                 :checkbox => %w(user_agree)}

      visit new_user_registration_path

      fill_in_form('user', attributes, inputs)
      select settlement.region.country.name, :from => 'user_country_id'
      wait_for_ajax
      select settlement.region.name, :from => 'user_region_id'
      wait_for_ajax
      select settlement.name, :from => 'user_settlement_id'
      submit_form
      sleep 5
      all('.error').count.should == 0
      user = User.last
      attributes.reject{|k,_| [:password, :password_confirmation, :confirmed_at, :preferred_currency, :agree].include?(k) }.each do |attr_name, value|
        user[attr_name].should == value
      end
      user.country.id.should == settlement.region.country.id
      user.region.id.should == settlement.region.id
      user.settlement.id.should == settlement.id
    end
  end
end

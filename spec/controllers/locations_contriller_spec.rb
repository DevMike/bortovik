# encoding: UTF-8
require 'spec_helper'

describe LocationsController do
  it "should return all country regions in appropriated order" do
    regions = FactoryGirl.create_list(:region, 3,
                                      :country => FactoryGirl.create(:country)).sort_by(&:name).reverse
    FactoryGirl.create_list(:region, 3,
                            :country => FactoryGirl.create(:country, :name => 'Russia'))

    get :get_collection, :country_id => regions.first.country_id

    response.body.should == regions.to_json(:only => [:id, :name])
  end

  it "should return all region settlements in appropriated order" do
    settlements = FactoryGirl.create_list(:settlement, 3,
                                          :region => FactoryGirl.create(:region)).sort_by(&:name).reverse
    FactoryGirl.create_list(:settlement, 3,
                            :region => FactoryGirl.create(:region, :name => 'Moscow'))

    get :get_collection, :region_id => settlements.first.region_id, :country_id => Country.first.id

    response.body.should == settlements.to_json(:only => [:id, :name])
  end
end
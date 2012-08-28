require 'spec_helper'

describe "routing to regions" do
  it "routes locations/:country_id/ to locations#get_collection for country_id" do
    { :get => "/locations/1" }.should route_to(
      :controller => "locations",
      :action => "get_collection",
      :country_id => "1")
  end

  it "routes locations/:country_id/:region_id to locations#get_collection for country_id and region_id" do
    { :get => "/locations/1/1" }.should route_to(
      :controller => "locations",
      :action => "get_collection",
      :country_id => "1",
      :region_id => "1")
  end
end
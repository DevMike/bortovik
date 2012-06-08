require 'spec_helper'

describe "routing to regions" do
  it "routes /countries/:country_id/regions to regions#index for country_id" do
    { :get => "/countries/1/regions" }.should route_to(
      :controller => "regions",
      :action => "index",
      :country_id => "1"
    )
  end

  it "does not expose full list of regions" do
    { :get => "/regions" }.should_not be_routable
  end

  it "does not show region by id" do
    { :get => "/regions/1" }.should_not be_routable
  end
end
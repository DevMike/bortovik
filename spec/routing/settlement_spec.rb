require 'spec_helper'

describe "routing to settlements" do
  it "routes /regions/:region_id/settlements to settlements#index for region_id" do
    { :get => "/regions/1/settlements" }.should route_to(
      :controller => "settlements",
      :action => "index",
      :region_id => "1"
    )
  end

  it "does not expose full list of settlements" do
    { :get => "/settlements" }.should_not be_routable
  end

  it "does not show settlements by id" do
    { :get => "/settlements/1" }.should_not be_routable
  end
end
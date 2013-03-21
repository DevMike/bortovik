require 'spec_helper'

describe CarsController do

  describe "GET 'get_collection'" do
    it "returns http success" do
      get 'get_collection'
      response.should be_success
    end
  end

end

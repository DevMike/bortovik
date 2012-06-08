require 'spec_helper'

describe HomeController do
  sign_in(:user)

  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      response.should be_success
    end
  end

end

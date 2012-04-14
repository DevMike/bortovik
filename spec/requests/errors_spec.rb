require 'spec_helper'

describe "Exceptions"  do

  context "404" do
    sign_in(:user)

    it "should raise exception when record not found" do
      should_raise_not_found { visit review_path(100500) }
    end

  end

end
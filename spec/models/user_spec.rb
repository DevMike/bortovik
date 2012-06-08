require 'spec_helper'

describe User do
  context "attributes" do
    it {should validate_presence_of :settlement}
  end
end

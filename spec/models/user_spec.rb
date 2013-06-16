require 'spec_helper'

describe User do
  context "attributes" do
    it { should validate_presence_of :settlement_id }
    it { should belong_to :settlement }
    it { should have_many :vehicles }
  end
end

require 'spec_helper'

shared_examples_for "locations" do
  it { should validate_presence_of :name }
end
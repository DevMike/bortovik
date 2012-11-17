require 'spec_helper'

shared_examples_for "cars" do |model_name|
  it { should validate_presence_of :name }
  it { should validate_presence_of :slug }
  it "should get slug from name when it isn't" do
    FactoryGirl.create(model_name, name: 'Some', slug: nil).slug.should == 'Some'
  end
end
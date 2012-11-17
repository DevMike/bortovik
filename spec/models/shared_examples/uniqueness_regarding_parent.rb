require 'spec_helper'

shared_examples_for "uniqueness regarding parent" do |factory, parent_id_name, validated|
  it "should validate uniqueness regarding parent" do
    unique_record = FactoryGirl.create(factory)

    invalid_record = FactoryGirl.build(factory)
    (validated + [parent_id_name]).each do |attr|
      invalid_record[attr] = unique_record[attr]
    end

    invalid_record.valid?
    validated.each do |attr|
      invalid_record.should have_errors_on(attr)
    end
  end
end
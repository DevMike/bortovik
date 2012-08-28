require 'spec_helper'

shared_examples_for "validate and save form" do
  context "specs" do
    before(:all) do
      @prefix = @model.downcase.gsub(/\s/, '_')
      @model_name = @model_alias || @model.capitalize
    end

    it "should validates" do
      fill_in_form(@prefix, @attributes, @inputs, :empty_set => true) if @context == 'update'
      click_button("#{@context.capitalize} #{@model_name}")
      all('.inline-errors').count.should == @expected_errors_count
    end

    it "should save" do
      fill_in_form(@prefix, @attributes, @inputs) if @context == 'create'
      click_button("#{@context.capitalize} #{@model_name}")
      page.should have_content("#{@model_name} was successfully #{@context}d.")
    end
  end
end
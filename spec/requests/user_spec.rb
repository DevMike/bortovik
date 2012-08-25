require 'spec_helper'
require 'requests/shared_examples/validate_and_save_form'

describe "Registrations" do
  context "agree checkbox behavior" do
    pending "should show border around the checkbox and denied submit when unchecked"
    pending "should allow submit when checked"
  end

  context "form" do
    #before(:all) do
    #  @context = self.class.description
    #  @attributes = FactoryGirl.attributes_for(:customer_request)
    #  @inputs = { :text => [:product, :description, :postal_code, :name] }
    #  @expected_errors_count = 4
    #end
    #before { visit edit_admin_customer_request_path(FactoryGirl.create(:customer_request)) }
    #
    #it_behaves_like "validate and save form"

    pending "validation"
    pending "saving"
  end

  pending "ajax field filling"
end

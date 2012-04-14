require 'spec_helper'
require 'requests/shared_examples/billing_info'

describe "BillingInfo" do
  sign_in(:admin)

  context "update" do

    it_behaves_like "billing info" do
      before(:all) {
        @success_info = "Billing info has been updated successfully"
      }
      before { visit edit_billing_info_path }
    end

  end
end
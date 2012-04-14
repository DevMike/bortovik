require 'spec_helper'

# Example
#describe "rake leads" do
#  describe ":complete_deprecated_leads" do
#
#    it "should complete customer_requests and set status 'not_interested' for all related leads, but for deprecated ones only" do
#      FactoryGirl.create_list(:customer_request, 5, :companies => FactoryGirl.create_list(:prospect, 5))
#      CustomerRequest.last.update_attribute(:created_at, 3.weeks.ago)
#      CustomerRequest.deprecated.count.should == 1
#      Rake::Task['leads:complete_deprecated_leads'].invoke
#
#      completed_requests = CustomerRequest.find_all_by_completeness(true)
#      completed_requests.count.should == 1
#      completed_requests.first.company_customer_requests.each do |lead|
#        lead.sale_status.should == 'not_interested'
#      end
#    end
#  end
#end
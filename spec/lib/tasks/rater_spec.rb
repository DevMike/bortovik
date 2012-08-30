#require 'spec_helper'
#
#describe "rake rater" do
#  before(:all) do
#    @rake = Rake.application
#  end
#
#  describe ":deliver" do
#
#    context "limits" do
#      before do
#        @total_invites_count = 10
#
#        @company_with_invites = FactoryGirl.build(:company)
#        @company_without_invites = FactoryGirl.build(:company)
#        Company.stub_chain(:not_deleted, :clients, :with_pending_invites, :find_each).and_yield(@company_with_invites)
#
#        @company_without_invites.should_not_receive(:increment_invitations_countres!)
#        @company_with_invites.stub_chain(:customers, :ready_to_invite, :count).and_return(@total_invites_count)
#
#      end
#
#      it "should select pending invites limited by daily limit" do
#        customer = FactoryGirl.build :customer
#        iterator_mock = mock('iterator')
#        iterator_mock.stub(:find_each).and_yield(customer)
#        @company_with_invites.stub_chain(:customers, :ready_to_invite, :limit).with(1).and_return(iterator_mock)
#
#        @company_with_invites.stub_chain(:current_subscription, :invitations_per_day_left).and_return(1)
#        @company_with_invites.stub_chain(:current_subscription, :invitations_per_month_left).and_return(2)
#        @company_with_invites.should_receive(:increment_invitations_countres!).with(1)
#        @rake["rater:deliver"].execute
#      end
#
#      it "should select pending invites limited by monthly limit" do
#        customer = FactoryGirl.build :customer
#        iterator_mock = mock('iterator')
#        iterator_mock.stub(:find_each).and_yield(customer)
#        @company_with_invites.stub_chain(:customers, :ready_to_invite, :limit).with(2).and_return(iterator_mock)
#        @company_with_invites.stub_chain(:current_subscription, :invitations_per_day_left).and_return(3)
#        @company_with_invites.stub_chain(:current_subscription, :invitations_per_month_left).and_return(2)
#        @company_with_invites.should_receive(:increment_invitations_countres!).with(2)
#        @rake["rater:deliver"].execute
#      end
#
#      it "should increment counters by processed invites count" do
#        customer = FactoryGirl.build :customer
#        iterator_mock = mock('iterator')
#        iterator_mock.stub(:find_each).and_yield(customer)
#        @company_with_invites.stub_chain(:customers, :ready_to_invite, :limit).with(20).and_return(iterator_mock)
#
#        @company_with_invites.stub_chain(:current_subscription, :invitations_per_day_left).and_return(30)
#        @company_with_invites.stub_chain(:current_subscription, :invitations_per_month_left).and_return(20)
#        @company_with_invites.should_receive(:increment_invitations_countres!).with(@total_invites_count)
#        @rake["rater:deliver"].execute
#      end
#    end
#
#    context "welcom message should be sent from" do
#      before do
#        @company = FactoryGirl.create(:company)
#        Company.stub_chain(:not_deleted, :clients, :with_pending_invites, :find_each).and_yield(@company)
#        @company.stub_chain(:customers, :ready_to_invite, :count).and_return(1)
#        @inviter = FactoryGirl.create(:user, :company => @company, :representative => true)
#        @other_user = FactoryGirl.create(:user, :company => @company, :representative => true)
#        @customer = FactoryGirl.create(:customer, :invited_by => @inviter)
#        iterator_mock = mock('iterator')
#        iterator_mock.stub(:find_each).and_yield(@customer)
#        @company.stub_chain(:customers, :ready_to_invite, :limit).and_return(iterator_mock)
#
#      end
#
#      it "from inviter if inviter is contact person" do
#        CustomerMailer.should_receive(:welcome_message).with(@inviter, @customer).and_return(double(CustomerMailer).as_null_object)
#        @rake["rater:deliver"].execute
#      end
#
#      it "from first contact person if inviter not representative" do
#        @inviter.update_attribute(:representative, false)
#        CustomerMailer.should_receive(:welcome_message).with(@other_user, @customer).and_return(double(CustomerMailer).as_null_object)
#        @rake["rater:deliver"].execute
#      end
#
#      it "inviter if company has no contact persons" do
#        @inviter.update_attribute(:representative, false)
#        @other_user.update_attribute(:representative, false)
#
#        CustomerMailer.should_receive(:welcome_message).with(@inviter, @customer).and_return(double(CustomerMailer).as_null_object)
#        @rake["rater:deliver"].execute
#
#      end
#    end
#
#  end
#end

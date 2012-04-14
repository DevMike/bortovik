# Example

#require 'spec_helper'
#
#describe InvitationsController do
#  sign_in(:user)
#  before { request.env["devise.mapping"] = Devise.mappings[:user] }
#
#  describe "#new" do
#    it_behaves_like "profile filled"
#  end
#
#  describe "#create" do
#    before(:all) do
#      @user_to_invite = FactoryGirl.attributes_for(:user_to_invite)
#      @user_to_invite[:first_invite] = true
#    end
#
#    it "should add :invite_members to getting_started set" do
#      post :create, :user => @user_to_invite
#      @current_user.company.reload.getting_started.should include(:invite_members)
#    end
#
#    it "should create new user" do
#      lambda {
#          post :create, :user => FactoryGirl.attributes_for(:user_to_invite)
#      }.should change(User, :count).by(1)
#    end
#
#    it "should not send invitations for active company users" do
#      existing_user = FactoryGirl.create(:user, :company => @current_user.company, :invitation_token => '1')
#      existing_user.accept_invitation!
#      attributes = @user_to_invite
#      attributes[:email] = existing_user.email
#      existing_user.should_not_receive(:invite!)
#      lambda {
#          post :create, :user => attributes
#      }.should_not change(User, :count)
#      assigns(:user).should_not be_valid
#    end
#
#    it "should send invitations to user without company" do
#      existing_user = FactoryGirl.create(:consumer)
#      attributes = @user_to_invite
#      attributes[:email] = existing_user.email
#      post :create, :user => attributes
#      response.should redirect_to(users_path)
#      flash[:notice].should == I18n.t("user.send_instructions", {:email=>existing_user.email, :scope=>"devise.invitations", :default=>[:send_instructions], :resource_name=>:user})
#    end
#
#    it "should send invitations to deleted users" do
#      existing_user = FactoryGirl.create(:user)
#      existing_user.destroy
#      attributes = @user_to_invite
#      attributes[:email] = existing_user.email
#      post :create, :user => attributes
#      response.should redirect_to(users_path)
#      existing_user.reload.should_not be_deleted
#      existing_user.should be_company_approved
#    end
#
#  end
#
#  context "should send email" do
#    it "should send only invite message when user was invited" do
#      lambda {
#        User.invite!(FactoryGirl.attributes_for(:user_to_invite)) do |u|
#          u.invited_by_id = @current_user.id
#          u.company       = @current_user.company
#        end
#      }.should change(ActionMailer::Base.deliveries,:size).by(1)
#    end
#  end
#end

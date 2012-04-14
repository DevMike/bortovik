require 'spec_helper'

# Example
#describe RegistrationsController do
#  before do
#    request.env["devise.mapping"] = Devise.mappings[:user]
#    @user_attributes = FactoryGirl.attributes_for(:user)
#    @user_attributes[:company_attributes] = { :name => '42 industries' }
#    @user_attributes.delete(:password)
#    @user_attributes.delete(:password_confirmation)
#  end
#
#  describe "#new" do
#    it "raises the wrong paid plan exception on not paid plan" do
#      expect {
#        get :new, :plan => 'starter'
#      }.to raise_error('Wrong paid plan: free')
#    end
#  end
#
#  describe "#create" do
#    it "sets company country the same as user country" do
#      post :create, :user => @user_attributes
#      assigns(:user).company.country.should eq(@user_attributes[:country])
#    end
#
#    it "sets 'admin' role for user with a new company" do
#      post :create, :user => @user_attributes
#      assigns(:user).roles.should eq([:admin])
#    end
#
#    # feature disabled
#=begin
#    it "sets 'member' role for user with existing company" do
#      FactoryGirl.create :company, :name => '42 industries'
#      post :create, :user => @user_attributes
#      assigns(:user).roles.should eq([:member])
#    end
#=end
#
#    it "creates silver subscription in sign up without a plan" do
#      post :create, :user => @user_attributes
#      subscription = assigns(:user).company.current_subscription
#      subscription.should be_persisted
#      subscription.plan_type.should eq('silver')
#    end
#
#    it "creates paid subscription" do
#      post :create, :user => @user_attributes, :plan => 'pro'
#      subscription = assigns(:user).company.current_subscription
#      subscription.should be_persisted
#      subscription.plan_type.should eq('gold')
#    end
#
#    it "creates paid subscription with coupon" do
#      FactoryGirl.create :discount, :code => 'code', :plan_type => 'gold'
#      post :create, :user => @user_attributes, :plan => 'pro', :coupon_code => 'code'
#      subscription = assigns(:user).company.current_subscription
#      subscription.discount.should be
#      subscription.discount.code.should eq('code')
#    end
#
#    it "creates unconfirmed user" do
#      post :create, :user => @user_attributes
#      assigns(:user).should_not be_confirmed
#    end
#
#    # Satisfy it when existing company user case will be uncommented
#    #pending "should not create another subscription for existing company"
#
#    context "emailing" do
#      it "sends confirmation email to new user if user with new company" do
#        Devise::Mailer.should_receive(:confirmation_instructions).and_return do
#          mock_model('Memail').tap { |m| m.should_receive :deliver }
#        end
#        UserMailer.should_not_receive(:new_member_message)
#        post :create, :user => @user_attributes
#      end
#
#      # TODO feature disabled
#      #pending "sends confirmation email to all admins but not user if user with existing company" do
#      #  existing_company = FactoryGirl.create(:company, :name => @user_attributes[:company_attributes][:name])
#      #  admins = FactoryGirl.create_list(:user, 2, :company => existing_company)
#      #
#      #  admins.size.times do
#      #    UserMailer.should_receive(:new_member_message).and_return do
#      #      mock_model('Memail').tap { |m| m.should_receive :deliver }
#      #    end
#      #  end
#      #
#      #  Devise::Mailer.should_not_receive(:confirmation_instructions)
#      #  post :create, :user => @user_attributes
#      #end
#
#      it "should not send welcome message when user sign up as a member of an existing company" do
#        user = FactoryGirl.create(:user)
#        unapproved_member_attributes = FactoryGirl.attributes_for(:unapproved_member, :company => user.company)
#        lambda { post :create, :user => unapproved_member_attributes }.should change(ActionMailer::Base.deliveries,:size).by(0)
#      end
#    end
#  end
#
#  describe "#coupon" do
#    it "returns tagline for the active coupon" do
#      FactoryGirl.create :discount, :code => 'code', :plan_type => 'silver', tagline: "code DE"
#      post :coupon, :code => 'code', :plan => 'basic'
#      response.body.should eq({ tagline: "code DE" }.to_json)
#    end
#
#    it "returns error if the coupon doesn't exist" do
#      post :coupon, :code => 'wrongcode'
#      response.body.should eq({ :error => { :type => :invalid, :message => "Invalid coupon code." } }.to_json)
#    end
#  end
#
#end

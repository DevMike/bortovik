require 'spec_helper'

# Example
#describe User do
#
#  context "attributes" do
#    context "common" do
#      subject { FactoryGirl.create :user }
#
#      it { should validate_uniqueness_of(:email) }
#
#      it "should be with default locale" do
#        subject.locale.should eql(Settings.system.default_locale)
#      end
#
#      it "validates email with custom message if same user was deleted" do
#        FactoryGirl.create(:user, :email => 'deleted-user@email.com').destroy
#        new_user = FactoryGirl.build(:user, :email => 'deleted-user@email.com')
#        new_user.valid?
#        new_user.errors[:email].should == ['account was deleted, please contact administration to restore it']
#      end
#    end
#
#    context "business" do
#      subject { FactoryGirl.create :user }
#
#      it { should be_persisted }
#
#      #presence
#      it { should validate_presence_of(:first_name) }
#      it { should validate_presence_of(:last_name) }
#      it { should validate_presence_of(:country) }
#      it { should validate_presence_of(:timezone) }
#      it { should validate_presence_of(:salutation) }
#
#      #inclusion
#      it { should allow_value('en').for(:locale) }
#      it { should_not allow_value('').for(:locale) }
#      it { should_not allow_value('ua').for(:locale) }
#
#      it { should allow_value('DE').for(:country) }
#      it { should_not allow_value('').for(:country) }
#      it { should_not allow_value('USSR').for(:country) }
#
#      it { should allow_value('mr').for(:salutation) }
#      it { should_not allow_value('').for(:salutation) }
#      it { should_not allow_value('student').for(:salutation) }
#
#      #mass assignment
#      it { should_not allow_mass_assignment_of(:position) }
#      it { should_not allow_mass_assignment_of(:representative) }
#    end
#
#    context "consumer" do
#      subject { FactoryGirl.create :consumer }
#
#      it { should be_persisted }
#    end
#
#  end
#
#  context "soft destroyable" do
#    before { @user = FactoryGirl.create(:user) }
#
#    context "should not fully destroyed user and dependencies" do
#      it "should not destroy user" do
#        expect { @user.destroy }.not_to change{ User.count }.from(1).to(0)
#      end
#
#      it "should mark as deleted soft destroyed user" do
#        expect { @user.destroy }.to change{ @user.deleted }.from(false).to(true)
#      end
#
#      context "destroy dependencies" do
#        it "should destroy reviews" do
#          FactoryGirl.create_list(:review, 2, :rated_company => FactoryGirl.create(:company_another), :user => @user)
#          expect { @user.destroy }.not_to change{ Review.count }.from(2).to(0)
#        end
#
#        it "should destroy customers" do
#          @customer = FactoryGirl.create(:customer)
#          expect { User.last.destroy }.not_to change{ Customer.count }.from(1).to(0)
#        end
#      end
#    end
#
#    context "should fully destroy user with dependencies" do
#      it "should destroy user" do
#        expect { @user.destroy! }.to change{ User.count }.from(1).to(0)
#      end
#
#      context "destroy dependencies" do
#        it "should destroy reviews" do
#          FactoryGirl.create_list(:review, 2, :rated_company => FactoryGirl.create(:company_another), :user => @user)
#          expect { @user.destroy! }.to change{ Review.count }.from(2).to(0)
#        end
#
#        it "should destroy customers" do
#          FactoryGirl.create(:customer)
#          expect { User.last.destroy! }.to change{ Customer.count }.from(1).to(0)
#        end
#      end
#    end
#  end
#
#  context "company approval" do
#    it "should be successful for a new one" do
#      new_company = FactoryGirl.build :company
#      user = FactoryGirl.build :unapproved_member, :company => new_company
#
#      user.save!
#      user.should be_company_approved
#    end
#
#    it "should not be for the existing one" do
#      existing_company = FactoryGirl.create :company
#      user = FactoryGirl.build :unapproved_member, :company => existing_company
#
#      user.save!
#      user.should_not be_company_approved
#    end
#  end
#
#  context "represenative" do
#    it "should be valid with company approved" do
#      member = FactoryGirl.create :member
#      member.representative = true
#      member.save.should be_true
#    end
#
#    it "should be invalid without company approved" do
#      member = FactoryGirl.create :unapproved_member
#      member.representative = true
#
#      member.save
#      member.should have(1).error_on(:representative)
#      member.errors[:representative].should == ["should company approved"]
#    end
#  end
#
#  describe "#name" do
#    it "should return full name" do
#      user = FactoryGirl.create :user, :first_name => 'John', :last_name => 'Doe'
#      user.name.should == 'John Doe'
#    end
#  end
#
#  describe ".representatives" do
#    it "should return only representatives of the company" do
#      company = FactoryGirl.create :company
#      representative = FactoryGirl.create :member, :company => company, :representative => true
#      member = FactoryGirl.create :admin, :company => company
#
#      company.representatives.should == [representative]
#    end
#  end
#
#  describe "#active_for_authentication?" do
#    before(:each) do
#      @user = FactoryGirl.create :user
#    end
#
#    specify { @user.should be_active_for_authentication }
#
#    context "company approvement" do
#      before { @user.update_attribute :company_approved, false }
#
#      specify { @user.should_not be_active_for_authentication }
#      specify { @user.inactive_message.should == :company_is_not_approved }
#
#      it "shoud return true if the user company is approved" do
#        @user.company_approved = true
#        @user.should be_active_for_authentication
#      end
#    end
#
#    context "soft destroyable" do
#      it "should not be active for authentication" do
#        @user.destroy
#        @user.should_not be_active_for_authentication
#        @user.inactive_message.should == :user_is_deleted
#      end
#    end
#  end
#
#  describe ".active" do
#    it "should prepare only active users" do
#      company = FactoryGirl.create :company
#
#      user = FactoryGirl.create :user, :company => company
#      unapproved_member = FactoryGirl.create :unapproved_member, :company => company
#      invited_user = FactoryGirl.create :invited_user, :company => company
#      deleted_user = FactoryGirl.create :user, :company => company
#      deleted_user.destroy
#
#      company.users.active.should == [user]
#    end
#  end
#
#  describe "#can_rate_company?" do
#
#    it "should return true if first rating" do
#      user = FactoryGirl.create(:user)
#      company = FactoryGirl.create(:company)
#      user.can_rate_company?(company).should be_true
#    end
#
#    it "should return true if existing rating older then limit allowed" do
#      review = FactoryGirl.create(:review, :created_at => Time.now - Settings.rating.same_rating_days_limit.days - 1.minute)
#      review.user.can_rate_company?(review.rated_company).should be_true
#    end
#
#    it "should return false if existing rating newer then limit allowed" do
#      review = FactoryGirl.create(:review, :created_at => Time.now - Settings.rating.same_rating_days_limit.days + 1.minute)
#      review.user.can_rate_company?(review.rated_company).should be_false
#    end
#  end
#
#  describe "upgrade account" do
#    before { @user = FactoryGirl.create(:consumer) }
#
#    it "should return true when user has been upgraded" do
#      @user.upgrade_account({
#        :company_attributes => { :name => 'Some' },
#        :first_name => @user.first_name,
#        :last_name => @user.last_name
#      }).should be_true
#    end
#
#    it "should return false when required params has not been entered" do
#      @user.upgrade_account({}).should be_false
#    end
#
#    it "should set role admin" do
#      @user.upgrade_account({
#        :company_attributes => { :name => 'Some' },
#        :first_name => @user.first_name,
#        :last_name => @user.last_name
#      })
#      @user.reload.has_role?(:admin).should be_true
#    end
#  end
#
#  context "email reconfirmation" do
#    it "should store email in separate field" do
#      user = FactoryGirl.create(:user)
#      new_email = Faker::Internet.email
#      user.email = new_email
#      user.save
#      user.unconfirmed_email.should == new_email
#    end
#
#    it "should not update email without confirmation" do
#      user = FactoryGirl.create(:user)
#      email_was = user.email
#      user.email = Faker::Internet.email
#      user.save
#      user.email.should == email_was
#    end
#
#    it "should send confirmation instructions" do
#      user = FactoryGirl.create(:user)
#      user.email = Faker::Internet.email
#      user.should_receive(:send_reconfirmation_instructions)
#      user.save
#    end
#
#    it "should regenerate confirmation token" do
#      user = FactoryGirl.create(:user, :confirmation_token => nil)
#      user.email = Faker::Internet.email
#      user.save
#      user.confirmation_token.should_not be_blank
#    end
#
#    describe "confirm!" do
#      before do
#        @user = FactoryGirl.create(:user)
#        @new_email = Faker::Internet.email
#        @user.email = @new_email
#        @user.save
#      end
#      it "should move unconfirmed_email to email field on confirmation" do
#        @user.confirm!
#        @user.email.should == @new_email
#      end
#    end
#  end
#
#end

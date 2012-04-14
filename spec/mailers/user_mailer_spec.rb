require "spec_helper"

# Example
#describe UserMailer do
#  include EmailSpec::Helpers
#  include EmailSpec::Matchers
#
#  context "welcome message" do
#    before do
#      ActionMailer::Base.deliveries = []
#      @user = FactoryGirl.create(:user, :confirmed_at => nil)
#      @user.send_confirmation_instructions
#      @email = ActionMailer::Base.deliveries.first
#    end
#
#    it "should set deliver to the user passed" do
#      @email.should deliver_to(@user.email)
#    end
#
#    it "should contain user name" do
#      @email.should have_body_text(/#{@user.name}/)
#    end
#
#    it "should set proper subject" do
#      @email.should have_subject('Welcome to geprueft.de')
#    end
#
#    it "should deliver successfully" do
#      lambda { @email.deliver }.should_not raise_error
#    end
#  end
#
#  # TODO feature is not used
#  #
#  #context "new member message" do
#  #  before do
#  #    @company = FactoryGirl.create(:company)
#  #    @user = FactoryGirl.create(:user, :company => @company)
#  #    @member = FactoryGirl.create(:user, :first_name => 'John', :last_name => 'Doe', :company => @company)
#  #    @email = UserMailer.new_member_message(@user, @member)
#  #  end
#  #
#  #  it "should send messages in user locale" do
#  #    @mail = UserMailer.new_member_message(FactoryGirl.create(:user, :locale => 'de'), FactoryGirl.create(:user))
#  #    @mail.should have_subject(I18n.t 'email.user.new_member.subject', :name => @user.name, :locale => :de)
#  #  end
#  #
#  #  it "should set deliver to the user passed" do
#  #    @email.should deliver_to(@user.email)
#  #  end
#  #
#  #  it "should contain user name" do
#  #    @email.should have_body_text(/#{@user.name}/)
#  #  end
#  #
#  #  it "should contain member name" do
#  #    @email.should have_body_text(/#{@member.name}/)
#  #  end
#  #
#  #  it "should set proper subject" do
#  #    @email.should have_subject('John Doe wants to be added to your company on geprueft.de')
#  #  end
#  #
#  #  it "should deliver successfully" do
#  #    lambda { @email.deliver }.should_not raise_error
#  #  end
#  #
#  #  it "should be added to the delivery queue" do
#  #    lambda { @email.deliver }.should change(ActionMailer::Base.deliveries,:size).by(1)
#  #  end
#  #end
#
#  context "invitations" do
#    before do
#      @owner = FactoryGirl.create(:user)
#      @invited_user = FactoryGirl.create(:invited_user)
#      @invited_user.invited_by_id = @owner.id
#      @mail = ::Devise.mailer.invitation_instructions(@invited_user)
#    end
#
#    it "should contain localized subject" do
#      @mail.should have_subject(I18n.t('devise.mailer.invitation_instructions.subject'))
#    end
#
#    it "should contain user name" do
#      @mail.should have_body_text(/#{@invited_user.name}/)
#    end
#
#    it "should contain invitation_token" do
#      @mail.should have_body_text(/#{@invited_user.invitation_token}/)
#    end
#
#    it "should contain owner name" do
#      @mail.should have_body_text(/#{@owner.name}/)
#    end
#
#    it "should deliver" do
#      @mail.should deliver_to(@invited_user.email)
#    end
#
#    it "should deliver successfully" do
#      lambda { @mail.deliver }.should_not raise_error
#    end
#  end
#
#  context "decline user message" do
#    before do
#      @company = FactoryGirl.create(:company, :name => '44 industries')
#      @user = FactoryGirl.create(:unapproved_member, :first_name => 'John',
#                                                     :last_name => 'Doe',
#                                                     :email => 'doe@mail.com',
#                                                     :company => @company)
#      @user.destroy
#      @email = UserMailer.decline_user_message(@user, @company)
#    end
#
#    it "should set deliver to the user passed" do
#      @email.should deliver_to('doe@mail.com')
#    end
#
#    it "should contain user name" do
#      @email.should have_body_text(/John Doe/)
#    end
#
#    it "should contain company name" do
#      @email.should have_body_text(/44 industries/)
#    end
#
#    it "should set proper subject" do
#      @email.should have_subject('You are declined to join the 44 industries on geprueft.de')
#    end
#
#    it "should deliver successfully" do
#      lambda { @email.deliver }.should_not raise_error
#    end
#
#    it "should be added to the delivery queue" do
#      lambda { @email.deliver }.should change(ActionMailer::Base.deliveries,:size).by(1)
#    end
#  end
#
#  context "reviewer welcome message" do
#    before do
#      user = FactoryGirl.create(:user, :confirmation_token => '123123')
#      @review = FactoryGirl.create(:review, :user => user)
#      @email = UserMailer::reviewer_welcome_message(@review, 'mypassword')
#    end
#
#    it "should set deliver to the user passed" do
#      @email.should deliver_to(@review.user.email)
#    end
#
#    it "should contain user name" do
#      @email.should have_body_text(/#{@review.user.name}/)
#    end
#
#    it "should contain login/pass" do
#      @email.should have_body_text(/mypassword/)
#      @email.should have_body_text(/#{@review.user.email}/)
#    end
#
#    it "should contain confirmation link" do
#      @email.should have_body_text(/users\/confirmation\?confirmation_token\=#{@review.user.confirmation_token}/)
#    end
#
#    it "should set proper subject" do
#      @email.should have_subject("You have rated #{@review.rated_company.name} company, please confirm your rating")
#    end
#
#    it "should deliver successfully" do
#      lambda { @email.deliver }.should_not raise_error
#    end
#  end
#
#  context "customer welcome message" do
#    before do
#      user = FactoryGirl.create(:user)
#      @review = FactoryGirl.create(:review, :user => user)
#      @email = UserMailer::customer_welcome_message(@review, 'mypassword')
#    end
#
#    it "should set deliver to the user passed" do
#      @email.should deliver_to(@review.user.email)
#    end
#
#    it "should contain user name" do
#      @email.should have_body_text(/#{@review.user.name}/)
#    end
#
#    it "should contain login/pass" do
#      @email.should have_body_text(/mypassword/)
#      @email.should have_body_text(/#{@review.user.email}/)
#    end
#
#    it "should not contain confirmation link" do
#      @email.should_not have_body_text(/users\/confirmation\?confirmation_token/)
#    end
#
#    it "should set proper subject" do
#      @email.should have_subject("You have rated #{@review.rated_company.name} company")
#    end
#
#    it "should deliver successfully" do
#      lambda { @email.deliver }.should_not raise_error
#    end
#  end
#
#  context "confirm review message" do
#    before do
#      user = FactoryGirl.create(:user)
#      @review = FactoryGirl.create(:review, :user => user, :confirmation_token => '123123')
#      @email = UserMailer::confirm_review_message(@review)
#    end
#
#    it "should set deliver to the user passed" do
#      @email.should deliver_to(@review.user.email)
#    end
#
#    it "should contain text" do
#      @email.should have_body_text(/Someone has used your email address to give a rating/)
#    end
#
#    it "should contain confirmation link" do
#      @email.should have_body_text(/rating\/confirm\?token\=#{@review.confirmation_token}/)
#    end
#
#    it "should set proper subject" do
#      @email.should have_subject("You have rated #{@review.rated_company.name} company, please confirm your rating")
#    end
#
#    it "should deliver successfully" do
#      lambda { @email.deliver }.should_not raise_error
#    end
#  end
#
#  context "daily summary message" do
#    before do
#      @user = FactoryGirl.create(:user)
#      @daily_received_reviews = FactoryGirl.create_list(:review, 5, :user => @user, :summary => 's'*100, :rated_company => @user.company)
#      @last_received_reviews = @daily_received_reviews[2..4]
#      @email = UserMailer::daily_summary_message(@user, @daily_received_reviews, @last_received_reviews)
#    end
#
#    it "should set deliver to the user passed" do
#      @email.should deliver_to(@user.email)
#    end
#
#    it "should contain daily received reviews amount" do
#      @email.should have_body_text("Sie haben heute #{@daily_received_reviews.count} neue Bewertungen auf geprueft.de erhalten")
#    end
#
#    it "should contain daily last daily reviews" do
#      @email.should have_body_text("Die letzten #{@last_received_reviews.count} Bewertungen von #{@daily_received_reviews.count} neuen Bewertungen:")
#      @last_received_reviews.each do |review|
#         @email.should have_body_text(review.user.name)
#         @email.should have_body_text("#{'s'*77}...")
#         @email.should have_body_text("#{review.rate}/5 Sternen")
#      end
#    end
#
#    it "should contain overall company rating" do
#      overall_rating = 4.5
#      Company.any_instance.stub(:overall_rating).and_return { overall_rating }
#      @email = UserMailer::daily_summary_message(@user, @daily_received_reviews, @last_received_reviews)
#      @email.should have_body_text("#{overall_rating}/5 Sternen")
#    end
#
#    it "should set proper subject" do
#      @email.should have_subject("geprueft.de - Neue Bewertungen")
#    end
#
#    it "should deliver successfully" do
#      lambda { @email.deliver }.should_not raise_error
#    end
#
#    it "should be added to the delivery queue" do
#      lambda { @email.deliver }.should change(ActionMailer::Base.deliveries,:size).by(1)
#    end
#  end
#
#  context ".prospect_upgrade_confirmation" do
#    before do
#      @user = FactoryGirl.create(:user, :confirmation_token => '123')
#      @email = UserMailer::prospect_upgrade_confirmation(@user)
#    end
#
#    it "should set deliver to the user passed" do
#      @email.should deliver_to(@user.email)
#    end
#
#    it "should contain text" do
#      @email.should have_body_text("Thank you for upgrading a geprueft.de account.")
#    end
#
#    it "should contain confirmation link" do
#      @email.should have_body_text(/users\/confirmation\?confirmation_token\=#{@user.confirmation_token}/)
#    end
#
#    it "should set proper subject" do
#      @email.should have_subject("geprueft.de - Account Upgrade")
#    end
#
#    it "should deliver successfully" do
#      lambda { @email.deliver }.should_not raise_error
#    end
#  end
#
#end

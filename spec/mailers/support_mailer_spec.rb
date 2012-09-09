require "spec_helper"

describe SupportMailer do
  include EmailSpec::Helpers
  include EmailSpec::Matchers

  context "contact message" do
    before do
      @message = ContactMessage.new(FactoryGirl.attributes_for(:contact_message))
      @email = SupportMailer.contact_message(@message)
    end

    it "should set deliver to the support email" do
      @email.should deliver_to(Settings.mail.contact_mail)
    end

    it "should set deliver from the entered email" do
      @email.should deliver_from(@message.email)
    end

    it "should contain user contact data" do
      @email.should have_body_text(@message.name)
      @email.should have_body_text(@message.email)
      @email.should have_body_text(@message.subject)
      @email.should have_body_text(@message.description)
    end

    it "should set proper subject" do
      @email.should have_subject('Contact message')
    end

    it "should deliver successfully" do
      lambda { @email.deliver }.should_not raise_error
    end

    it "should be added to the delivery queue" do
      lambda { @email.deliver }.should change(ActionMailer::Base.deliveries,:size).by(1)
    end
  end
end
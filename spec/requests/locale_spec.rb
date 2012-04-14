require 'spec_helper'

describe "Locales"  do
  sign_in(:user)

  after do
    reset_locale
  end

  context "as guest" do

    before(:each) do
      visit dashboard_path
    end

    it "should have default locale" do
      I18n.locale.should eql(Settings.system.default_locale.to_sym)
    end

    # TODO feature disabled
    #pending "should be able to switch locale" do
    #  find(".de").click
    #  I18n.locale.should eql(:de)
    #end
  end

  context "as logged user" do
    sign_in(:user)

    it "should switch to user locale after login" do
      I18n.locale.should eql(@current_user.locale.to_sym)
    end

    # TODO feature disabled
    #pending "should allow user to manually switch locales" do
    #  visit edit_user_registration_path
    #  find(".de").click
    #  I18n.locale.should eql(:de)
    #end

  end
end

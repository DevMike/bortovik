require 'spec_helper'

describe "Calls" do
  context "list" do
    sign_in(:user)

    it "should open popup dialog with feedback details", :js => true do
      call = FactoryGirl.create(:call, :company => @current_user.company)

      visit calls_path

      find('a.icon.details').click

      within('#dialog') do
        page.should have_content(call.caller_phone)
      end
    end

    it "should switch to calls tab", :js => true do
      visit feedbacks_path

      find('#inquiry_type_calls').click

      page.should have_content('Phone calls')
    end

    context "when there are no any calls" do
      it "should show a message that no calls when virtual phone is" do
        @current_user.company.update_attribute(:virtual_phone, '9.8-2 0 9 9 7 6')
        visit calls_path
        page.should have_content('No calls')
      end

      it "should show another message when virtual phone is absent" do
        visit calls_path
        page.should have_content('Wollen Sie sehen, wer Sie')
      end
    end
  end
end
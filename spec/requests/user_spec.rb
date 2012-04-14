require 'spec_helper'
require 'requests/shared_examples/delete_image'

describe "Users" do
  def invite_team_member_via_form(first_name, last_name, email)
    visit new_user_invitation_path
    within('#new_user') do
      fill_in 'First name', :with => first_name
      fill_in 'Last name', :with => last_name
      fill_in 'Email', :with => email
    end
    click_button('Invite team member')
  end

  describe "routes" do
    context "after sign in path" do
      it "should routes to dashboard after sign in" do
        user = FactoryGirl.create(:user)
        visit new_user_session_path
        within('#new_user') do
          fill_in 'Email', :with => user.email
          fill_in 'Password', :with => user.password
        end
        find('input[@name=commit]').click
        current_path.should eq(dashboard_path)
      end
    end
  end

  context "Member" do
    context "edit" do
      sign_in(:user)

      before do
        visit edit_user_registration_path
        @user2 = FactoryGirl.create(:user, :email=>'example2@gmail.com')
      end

      it "show form when user logged" do
        page.should have_selector('#edit_user')
      end

      it "check for required email" do
        within('#edit_user') do
          fill_in 'Email', :with => ''
        end
        click_button('Save changes')
        should_have_error_for(".email")
      end

      it "check for required confirmation password" do
        within('#edit_user') do
          fill_in 'Password', :with => 'pass'
          fill_in 'Confirm password', :with => ''
        end
        click_button('Save changes')
        should_have_error_for(".password")
      end

      it "error trying update email to existing" do
        within('#edit_user') do
          fill_in 'Email', :with => @user2.email
        end
        click_button('Save changes')

        should_have_error_for(".email")
      end

      it "should postpone email change" do
        old_email = @current_user.email
        new_email = Faker::Internet.email
        within("#edit_user") do
          fill_in("user_email", :with=> new_email)
        end
        find('input[@name=commit]').click
        find_field("user_email").value.should eql(old_email)
        page.should have_content(new_email)
      end

      it "save when fill all required fields" do
        file_delete('user', 'photo', @current_user.id)
        user_fields = [:first_name, :last_name, :timezone, :office_phone, :mobile_phone, :fax, :title]

        new_user_attributes = FactoryGirl.attributes_for("user_another")
        not_fields = [:timezone, :remember_me, :country, :locale, :photo]
        within("#edit_user") do
          user_fields.reject{|c| not_fields.include?(c)}.each do |field|
            fill_in("user_#{field}", :with=>new_user_attributes[field])
          end
          attach_file('photo', "#{Rails.root}/spec/factories/images/company_logo.png")
          select(new_user_attributes[:timezone], :from => 'user_timezone')
          #select('German', :from => 'user_locale')
          choose  'Mr.'
        end
        find('input[@name=commit]').click

        page.should have_content("You updated your account successfully")
        user_fields.each do |field|
          find_field("user_#{field}").value.should eql(new_user_attributes[field])
        end
        file_exists?('user', 'photo', @current_user.id).should be_true
      end

      it "shows flash alert on validation error" do
        within('#edit_user') do
          fill_in 'Email', :with => ''
        end
        click_button('Save changes')
        page.should have_content(I18n.t 'flash.actions.update.alert')
      end
    end

    context "default photos depend on gender" do
      sign_in(:frau)

      it "should be default photo for frau" do
        visit edit_user_registration_path
        page.should have_css("img[src='/assets/user_mrs_missing.png']")
        page.should have_css("img[src='/assets/user_mrs_missing_thumb.png']")
      end
    end

    context "delete logo", :js => true do
      it_behaves_like "delete image" do
        sign_in(:user)

        before(:all) do
          @model = 'user'
          @file_field = 'photo'
          @success_message = 'You updated your account successfully'
        end

        before do
          visit edit_user_registration_path
          attach_file('user_photo', Rails.root + 'spec/factories/images/company_logo.png')
          click_link 'Delete photo'
        end
      end

      context "photo depend on gender" do
        sign_in(:frau)

        it "should show default photo for frau" do
          visit edit_user_registration_path
          attach_file('user_photo', Rails.root + 'spec/factories/images/company_logo.png')
          click_link 'Delete photo'
          page.should have_css("img[src='/assets/user_mrs_missing.png']")
        end
      end
    end

    context "Team" do

      sign_in(:user)

      before(:each) do
        @user_to_inviting = FactoryGirl.attributes_for(:user_to_invite)
        @owner = FactoryGirl.create(:admin)
      end

      context "current admin" do

        before(:each) do
          FactoryGirl.create(:user, :company => @current_user.company)
          visit users_path
        end

        it "should not see edit/delete buttons for himself" do
          page.should_not have_css("#user_#{@current_user.id}.member ul.actions")
        end

        it "invitation button should be visible and redirectable" do
          click_link('Invite new team member')
          page.should have_content('Invite a new team member')
        end
      end

      context "invitation new team member" do

        before(:each) do
          visit new_user_invitation_path
        end

        it "should be error trying invite user with existing email" do
          invite_team_member_via_form(@user_to_inviting[:first_name],@user_to_inviting[:last_name],@owner.email)
          should_have_error_for(".email")
        end

        it "should be errors when user required fields don't filled in'" do
          invite_team_member_via_form('','','')
          should_have_errors_for("#new_user", 3)
          page.should have_content(I18n.t 'flash.actions.update.alert')
        end
        
        it "should be info message when form was submitted correct and redirect to dashboard" do
          invite_team_member_via_form(@user_to_inviting[:first_name],@user_to_inviting[:last_name],@user_to_inviting[:email])
          page.should have_content("An invitation email has been sent to "+@user_to_inviting[:email])
          #redirecting test
          page.should have_selector('#team-content')
        end
      end

      context "after invite actions" do
        before(:each) do
          invite_team_member_via_form(@user_to_inviting[:first_name],@user_to_inviting[:last_name],@user_to_inviting[:email])
        end

        context "resend notification for admin", :js => true do

          it "should display info message that invitation has been resent" do
            visit users_path
            click_link('Resend invitation')

            page.should have_content("An invitation email has been sent to "+@user_to_inviting[:email])

            #redirecting test
            page.should have_selector('#team-content')
          end

        end

        context "change possibility to invite invited user " do
          it "should display message trying invite a user that has been invited already", :js => true do
            @owner_another = FactoryGirl.create(:user_another)
            @invited_user_another = User.invite!(Factory.attributes_for(:user_to_invite_another)) do |u|
              u.invited_by_id = @owner_another.id
            end
            invite_team_member_via_form(@invited_user_another.first_name,@invited_user_another.last_name,@invited_user_another.email)
            page.should have_content("has already been taken")
          end
        end

        context "possibility to edit users that didn't accept invitation yet" do
          it "should delete invited member" do
            all('a.confirm_dialog').last.click
            click_button('Delete team member')
            page.should have_content("User was successfully removed")
          end
        end

#feature disabled
=begin
        context "resend notification for member" do
          sign_in(:member)
          it "should not display resend invitation link" do
            visit users_path
            page.should_not have_css("a", :text=>"Resend invitation")
          end
        end
=end
        context "after accept invitation actions for admin" do

          before(:each) do
            User.find_by_email(@user_to_inviting[:email]).accept_invitation!
            visit users_path
          end

#feature disabled
=begin
          it "should edit user permissions" do
            all('a.edit').last.click
            choose('Admin')
            click_button('Save changes')
            page.should have_content("User permissions were successfully updated")
          end
=end

          it "should delete user" do
            all('a.confirm_dialog').last.click
            click_button('Delete team member')
            page.should have_content("User was successfully removed")
          end

        end

#feature disabled
=begin
        context "after accept invitation actions for member" do
          sign_in(:member)

          it "should not display actions for member" do
            visit users_path
            page.should_not have_selector("a.edit")
            page.should_not have_selector("a.confirm_dialog")
            page.should_not have_css("a[href='#{edit_company_path}']")
            page.should_not have_css("input[value='Invite a new team member']")
          end
        end
=end
      end
    end
  end

  context "consumer", :js => true do
    sign_in(:consumer)

    before do
      visit reviews_path
      click_link "upgrade for 30 days testing"
    end

    context "upgrade account" do
      context "successfully" do
        before do
          within('#upgrade_account') do
            fill_in "I'm a business owner and my company name is", :with => "Some"
          end
          find('input[@name=commit]').click
        end

        it "should be info message" do
          wait_for_ajax { page.should have_content("Your account has been upgraded to full business account") }
        end

        it "should redirect to member dashboard" do
          wait_for_ajax { page.should have_css(".dashboard", :text => "Dashboard") }
        end
      end

      context "errors" do
        it "should have errors when form didn't filled" do
          within('#upgrade_account') do
            fill_in "First name", :with => ""
            fill_in "Last name", :with => ""
          end
          find('input[@name=commit]').click
          wait_for_ajax { all('.error').count.should eq(3) }
        end

        it "should have errors when company name is already used" do
          within('#upgrade_account') do
            fill_in "I'm a business owner and my company name is", :with => FactoryGirl.create(:user).company.name
          end
          find('input[@name=commit]').click
          wait_for_ajax { all('.error').count.should eq(1) }
        end
      end
    end
  end
end

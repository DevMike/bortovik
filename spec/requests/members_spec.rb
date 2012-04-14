# TODO feature is not used
#
#require 'spec_helper'
#
#describe "Members" do
#  sign_in(:user)
#
#  before(:each) do
#    @unapproved_member = FactoryGirl.create :unapproved_member,
#                                            :first_name => 'John',
#                                            :last_name => 'Doe',
#                                            :email => 'john@doe.com',
#                                            :company => @current_user.company
#  end
#
#  it "adds a new member to the team on an accepted request" do
#    visit users_path
#
#    within('#inactive_list') do
#      click_link('Accept request and add to the company')
#    end
#
#    page.should have_content('The user John Doe (john@doe.com) has been added to your company')
#    page.should_not have_selector('#inactive_list')
#    within('#team-content') { page.should have_content('John Doe') }
#  end
#
#  it "removes the new member on a declined request" do
#    visit users_path
#
#    within('#inactive_list') do
#      click_link('Decline request and remove')
#    end
#
#    page.should have_content('The request from John Doe (john@doe.com) has been declined.')
#    page.should_not have_selector('#inactive_list')
#    within('#team-content') { page.should_not have_content('John Doe') }
#  end
#end

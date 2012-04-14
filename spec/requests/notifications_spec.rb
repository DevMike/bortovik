require 'spec_helper'

describe "Notifications", :js => true    do

  #sign_in(:user)
  #
  #context "Dropdown" do
  #
  #  before(:each) do
  #    visit dashboard_path
  #  end
  #
  #  it "open/close on counter click" do
  #    find('.counter').click
  #    find('.notification menu').should be_visible
  #    find('.counter').click
  #
  #    find('.notification menu').should_not be_visible_after_delay
  #  end
  #
  #  it "close on body click" do
  #    find('.counter').click
  #    find('body').click
  #
  #    find('.notification menu').should_not be_visible_after_delay
  #  end
  #
  #end
  #
  #context "Messages" do
  #
  #  before(:each) do
  #    create_user_notifications(@current_user, 3, 4)
  #    visit dashboard_path
  #  end
  #
  #  it "counter shows unread messages" do
  #    within('.counter') do
  #      page.should have_content(3)
  #    end
  #  end
  #
  #  it "show minimum 5 latest notifications" do
  #    find('.counter').click
  #    page.all('.notification menu li.message').size.should eq(5)
  #  end
  #
  #  it "mark notifications as read on close" do
  #    find('.counter').click # open
  #    find('.counter').click # close
  #    wait_until{!find('.notification menu').visible?}
  #    within('.counter') do
  #      page.should have_content('0')
  #    end
  #    page.should have_css('.notification.zero')
  #  end
  #end

end

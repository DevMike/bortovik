require 'spec_helper'

shared_examples_for "delete image" do
  #TODO: will be actual when ability to upload images will be enabled in tests
  context "delete image" do
    it "should replaced current image to default" do
      page.should have_css('.resource-logo>img', :src => "/assets/#{@model}_missing.png")
    end

    it "should replaced remove flag value to true" do
      find("##{@model}_remove_#{@file_field}")['value'].should == 'true'
    end

    it "should successfully update profile" do
      find('input[@name=commit]').click
      page.should have_content(@success_message)
    end

    it "the logo on the page should be default" do
      find('input[@name=commit]').click
      page.should have_css('.resource-logo>img', :src => "/assets/#{@model}_missing.png")
    end
  end
end
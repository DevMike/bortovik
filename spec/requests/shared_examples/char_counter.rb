require 'spec_helper'

shared_examples_for "char counter" do
  context "char counter", :js => true do

     it "should change count" do
       within("#{@form_selector}") do
         fill_in("#{@field}", :with => @new_description)
       end
       page.should have_content("#{(@char_limit - @new_description.length).abs} chars more than #{@char_limit}")
     end

  end
end
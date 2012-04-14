require 'spec_helper'

describe "Widget" do

  context "reviews", :js => true do
    it "should escape user inserted data" do
      Subscription.any_instance.stub(:widget?).and_return{true}

      evil_summary = "'); alert('hello!'); document.write('"
      review = FactoryGirl.create(:review_public, :summary => evil_summary)
      visit widget_path(:id => review.rated_company.slug, :locale => 'en')

      page.should have_content(%q['); alert(\'hello!\'); document.write(\'])
    end

    it "should display upgrade image if feature not available" do
      Subscription.any_instance.stub(:widget?).and_return{false}

      review = FactoryGirl.create(:review_public)
      visit widget_path(:id => review.rated_company.slug, :locale => 'en')

      page.should have_css('.salesworker-widget-suspended')
    end
  end

  context "badge", :js => true do
    it "should display upgrade message if feature not available" do
      Subscription.any_instance.stub(:badge?).and_return{false}
      review = FactoryGirl.create(:review_public)
      visit badge_path(:id => review.rated_company.slug, :locale => 'en')
      page.should have_css(".salesworker-suspended-message")
    end

    it "should display empty message if no reviews" do
      Subscription.any_instance.stub(:badge?).and_return{true}
      company = FactoryGirl.create(:company)
      visit badge_path(:id => company.slug, :locale => 'en')
      page.should have_css(".salesworker-empty-message")
    end

    it "should display company name and total reviews count" do
      Subscription.any_instance.stub(:badge?).and_return{true}
      company = FactoryGirl.create(:company)
      review = FactoryGirl.create_list(:review_public, 3, :rated_company => company)
      visit badge_path(:id => company.slug, :locale => 'en')
      within('.salesworker-count') do
        page.should have_content("3")
      end
      within('.salesworker-total') do
        page.should have_content("reviews")
      end
    end
  end
end

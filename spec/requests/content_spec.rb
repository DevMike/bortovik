require 'spec_helper'

describe "Content" do
  context "sidebar" do
    before do
      @root = FactoryGirl.create(:content_category)
    end

    it "should render child categories if they has articles" do
      cat = FactoryGirl.create(:content_category, :parent => @root)
      FactoryGirl.create(:content_article, :parent => cat)
      visit content_path(@root)
      page.should have_content(cat.name)
    end

    it "should render child categories if they has subcagories" do
      cat = FactoryGirl.create(:content_category, :parent => @root)
      FactoryGirl.create(:content_article, :parent => cat)
      visit content_path(@root)
      page.should have_content(cat.name)
    end

    it "should render two levels of categories" do
      cat = FactoryGirl.create(:content_category, :parent => @root)
      subcat = FactoryGirl.create(:content_category, :parent => cat)
      visit content_path(@root)
      page.should have_content(subcat.name)
    end
  end
end

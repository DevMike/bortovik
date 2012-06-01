module ApplicationHelper
  def country_collection
    Country.all.map(&:name)
  end
end

class Location < ActiveRecord::Base
  self.abstract_class = true

  attr_accessible :name

  validates :name, :presence => true
end
class Location < ActiveRecord::Base
  self.abstract_class = true

  attr_accessible :name, :russian_name

  validates :name, :presence => true, :uniqueness => true
  validates :russian_name, :presence => true, :uniqueness => true
end
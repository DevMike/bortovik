class Car < ActiveRecord::Base
  self.abstract_class = true

  attr_accessible :name, :description

  validates_presence_of :name
  validates_uniqueness_of :name
end
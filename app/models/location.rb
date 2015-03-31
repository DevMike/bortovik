class Location < ActiveRecord::Base
  self.abstract_class = true

  validates :name, presence: true
end

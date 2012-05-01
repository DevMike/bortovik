class Region < ActiveRecord::Base
  belongs_to :country
  has_many :settlements
  attr_accessible :name, :russian_name

  validates :name, :presence => true
end

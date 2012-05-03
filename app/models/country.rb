class Country < ActiveRecord::Base
  has_many :regions
  attr_accessible :name, :russian_name

  validates :name, :presence => true, :uniqueness => true
  validates :russian_name, :presence => true
end

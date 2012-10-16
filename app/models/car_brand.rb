class CarBrand < ActiveRecord::Base
  attr_accessible :name

  has_many :car_models, dependent: :destroy

  validates_presence_of :name
  validates_uniqueness_of :name
end

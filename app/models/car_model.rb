class CarModel < ActiveRecord::Base
  attr_accessible :name

  belongs_to :car_brand
  has_many :car_modifications, dependent: :destroy

  validates_presence_of :name
end

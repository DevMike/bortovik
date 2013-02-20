class Vehicle < ActiveRecord::Base
  belongs_to :car_modification
  has_many :users, through: :user_vehicles
  has_many :car_feature_car_modifications, through: :car_modification
  attr_accessible :color, :engine_volume, :mileage, :transmission

  validates_presence_of :color, :mileage, :car_modification

  alias_method :features, :car_feature_car_modifications
end

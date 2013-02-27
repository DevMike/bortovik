class Vehicle < ActiveRecord::Base
  belongs_to :car_modification
  has_many :user_vehicles
  has_many :users, through: :user_vehicles
  has_many :car_feature_car_modifications, through: :car_modification
  alias_method :features, :car_feature_car_modifications

  attr_accessible :color, :engine_volume, :mileage, :transmission, :car_modification_id

  validates_presence_of :color, :mileage, :car_modification

  #accepts_nested_attributes :car_modification

  def owner
    mapper = user_vehicles.detect{ |uv| uv.date_of_sale.nil? }
    mapper.user if mapper.present?
  end
end

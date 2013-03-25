# encoding: utf-8

class Vehicle < ActiveRecord::Base
  extend Enumerize

  COLORS = %w(чёрный белый жёлтый красный зелёный синий)
  enumerize :color, in: COLORS
  TRANSMISSION = %w(механика автомат)
  enumerize :transmission, in: TRANSMISSION

  belongs_to :car_modification
  has_many :user_vehicles
  has_many :users, through: :user_vehicles
  has_many :car_feature_car_modifications, through: :car_modification
  alias_method :features, :car_feature_car_modifications

  attr_accessible :color, :engine_volume, :mileage, :transmission, :car_modification_id
  attr_accessor :car_brand_id, :car_model_id

  validates_presence_of :color, :mileage, :car_modification

  delegate :car_model, to: :car_modification
  delegate :car_brand, to: :car_model

  def owner
    mapper = user_vehicles.detect{ |uv| uv.date_of_sale.nil? }
    mapper.user if mapper.present?
  end

  def name
    "#{car_brand.name} #{car_model.name}"
  end
end

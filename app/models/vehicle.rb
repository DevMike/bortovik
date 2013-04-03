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

  attr_accessible :color, :engine_volume, :mileage, :transmission, :car_modification_id, :vin, :release_year
  attr_accessor :car_brand_id, :car_model_id
  accepts_nested_attributes_for :user_vehicles

  validates_presence_of :color, :mileage, :car_modification
  validates_numericality_of :mileage, :engine_volume

  delegate :car_model, to: :car_modification
  delegate :car_brand, to: :car_model

  delegate :mileage_on_purchase, :date_of_purchase, to: :owner_mapper

  def owner
    owner_mapper.user if owner_mapper.present?
  end

  def name
    "#{car_brand.name} #{car_model.name}"
  end

  private
  def owner_mapper
    user_vehicles.detect{ |uv| uv.date_of_sale.nil? }
  end
end

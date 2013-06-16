# encoding: utf-8

class Vehicle < ActiveRecord::Base
  extend Enumerize

  COLORS = %w(чёрный белый жёлтый красный зелёный синий)
  enumerize :color, in: COLORS
  TRANSMISSION = %w(
                    Ручная/механическая
                    Типтроник
                    Автомат
                    Адаптивная
                    Вариатор
  )
  enumerize :transmission, in: TRANSMISSION

  belongs_to :car_modification
  has_many :user_vehicles
  has_many :users, through: :user_vehicles
  has_many :car_feature_car_modifications, through: :car_modification
  alias_method :features, :car_feature_car_modifications

  attr_accessible :color, :engine_volume, :mileage, :transmission, :car_modification_id, :car_model_id, :car_brand_id, :vin, :release_year, :user_vehicles_attributes
  attr_accessor :car_brand_id, :car_model_id

  accepts_nested_attributes_for :user_vehicles

  validates_presence_of :color, :transmission, :car_modification_id, :car_model_id, :car_brand_id, :release_year, :engine_volume, :mileage
  validates_numericality_of :mileage
  validates :release_year, numericality: { greater_than_or_equal_to: 1900, less_than_or_equal_to: Time.now.year }
  validates :engine_volume, numericality: { greater_than: 0.1, less_than_or_equal_to: 10.0 }

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

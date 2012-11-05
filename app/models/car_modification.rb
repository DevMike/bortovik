class CarModification < ActiveRecord::Base
  attr_accessible :name, :description

  belongs_to :car_model
  has_many :car_feature_car_modifications, dependent: :destroy
  has_many :car_features, through: :car_feature_car_modifications

  validates_presence_of :name

  delegate :car_brand, :to => :car_model

  search_method :car_brand_eq, :splat_param => true
  def self.car_brand_eq(id)
    joins([:car_model => :car_brand]).where("#{CarBrand.table_name}.id = ?", id)
  end
end

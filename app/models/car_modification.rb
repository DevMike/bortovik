class CarModification < ActiveRecord::Base
  attr_accessible :name

  belongs_to :car_model
  has_many :car_feature_car_modifications, dependent: :destroy
  has_many :car_features, through: :car_feature_car_modifications

  validates_presence_of :name
end

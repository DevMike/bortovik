class CarFeatureCategory < ActiveRecord::Base
  attr_accessible :name

  has_many :car_features, dependent: :destroy

  validates_presence_of :name
end

class CarFeatureCarModification < ActiveRecord::Base
  attr_accessible :value

  belongs_to :car_feature
  belongs_to :car_modification

  validates_presence_of :car_feature, :car_modification, :value

  #delegate :name, :car_feature
end

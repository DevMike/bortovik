# == Schema Information
#
# Table name: car_feature_car_modifications
#
#  id                  :integer          not null, primary key
#  car_feature_id      :integer
#  car_modification_id :integer
#  value               :string(255)
#

class CarFeatureCarModification < ActiveRecord::Base
  belongs_to :car_feature
  belongs_to :car_modification

  validates_presence_of :car_feature, :car_modification, :value
end

# == Schema Information
#
# Table name: car_feature_car_modifications
#
#  id                  :integer          not null, primary key
#  car_feature_id      :integer
#  car_modification_id :integer
#  value               :string
#

class CarFeatureCarModification < ActiveRecord::Base
  belongs_to :car_feature
  belongs_to :car_modification

  validates_presence_of :car_feature, :car_modification, :value

  delegate :name, to: :car_feature
end

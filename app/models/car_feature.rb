# == Schema Information
#
# Table name: car_features
#
#  id                      :integer          not null, primary key
#  name                    :string
#  car_feature_category_id :integer
#  created_at              :datetime
#  updated_at              :datetime
#

class CarFeature < ActiveRecord::Base
  belongs_to :car_feature_category
  has_many :car_feature_car_modifications, dependent: :destroy
  has_many :car_modifications, through: :car_feature_car_modifications

  validates_presence_of :name
end

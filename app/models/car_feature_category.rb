# == Schema Information
#
# Table name: car_feature_categories
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class CarFeatureCategory < ActiveRecord::Base
  has_many :car_features, dependent: :destroy

  validates_presence_of :name
end

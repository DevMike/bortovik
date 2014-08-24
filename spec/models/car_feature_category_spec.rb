# == Schema Information
#
# Table name: car_feature_categories
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

require 'spec_helper'

describe CarFeatureCategory do
  context 'attributes' do
    it { should validate_presence_of :name }
    it { should have_many :car_features }
  end
end

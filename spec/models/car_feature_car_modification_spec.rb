# == Schema Information
#
# Table name: car_feature_car_modifications
#
#  id                  :integer          not null, primary key
#  car_feature_id      :integer
#  car_modification_id :integer
#  value               :string(255)
#

require 'spec_helper'

describe CarFeatureCarModification do
  context 'attributes' do
    it { should validate_presence_of :value }
    it { should validate_presence_of :car_feature }
    it { should validate_presence_of :car_modification }
    it { should belong_to :car_feature }
    it { should belong_to :car_modification }
  end
end

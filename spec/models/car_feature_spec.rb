require 'spec_helper'

describe CarFeature do
  context 'attributes' do
    it { should validate_presence_of :name }
    it { should belong_to :car_feature_category }
    it { should have_many :car_feature_car_modifications }
  end
end

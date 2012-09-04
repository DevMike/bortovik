require 'spec_helper'

describe CarFeatureCategory do
  context 'attributes' do
    it { should validate_presence_of :name }
    it { should have_many :car_features }
  end
end

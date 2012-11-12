require 'spec_helper'

describe CarModification do
  context 'attributes' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :slug }
    it { should belong_to :car_model }
    it { should have_many :car_feature_car_modifications }
  end
end

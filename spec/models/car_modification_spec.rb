require 'spec_helper'

describe CarModification do
  context 'attributes' do
    it { should belong_to :car_model }
    it { should have_many :car_feature_car_modifications }
  end

  it_behaves_like "cars", :car_modification
end

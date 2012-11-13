require 'spec_helper'

describe CarModel do
  context 'attributes' do
    it { should belong_to :car_brand }
    it { should have_many :car_modifications }
  end

  it_behaves_like "cars", :car_model
end

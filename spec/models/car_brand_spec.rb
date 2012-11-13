require 'spec_helper'

describe CarBrand do
  context 'attributes' do
    it { should have_many :car_models }
  end

  it_behaves_like "cars", :car_brand
end

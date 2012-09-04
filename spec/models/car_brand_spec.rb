require 'spec_helper'

describe CarBrand do
  context 'attributes' do
    it { should validate_presence_of :name }
    it { should validate_uniqueness_of :name }
    it { should have_many :car_models }
  end
end

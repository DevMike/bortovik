require 'spec_helper'

describe CarModel do
  context 'attributes' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :slug }
    it { should belong_to :car_brand }
    it { should have_many :car_modifications }
  end
end

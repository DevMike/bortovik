# == Schema Information
#
# Table name: car_brands
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#  description :text
#  slug        :string(255)
#

require 'spec_helper'

describe CarBrand do
  context 'attributes' do
    it { should have_many :car_models }
  end

  # it_behaves_like "cars", :car_brand
end

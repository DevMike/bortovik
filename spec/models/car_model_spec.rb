# == Schema Information
#
# Table name: car_models
#
#  id           :integer          not null, primary key
#  name         :string
#  car_brand_id :integer
#  created_at   :datetime
#  updated_at   :datetime
#  description  :text
#  slug         :string
#

require 'spec_helper'

describe CarModel do
  context 'attributes' do
    it { should belong_to :car_brand }
    it { should have_many :car_modifications }
    it { should validate_uniqueness_of :slug}
  end

  # it_behaves_like "cars", :car_model
  # it_behaves_like "uniqueness regarding parent", :car_model, :car_brand_id, [:name]
end

# == Schema Information
#
# Table name: car_modifications
#
#  id           :integer          not null, primary key
#  name         :string(255)
#  car_model_id :integer
#  created_at   :datetime
#  updated_at   :datetime
#  description  :text
#  slug         :string(255)
#

require 'spec_helper'

describe CarModification do
  context 'attributes' do
    it { should belong_to :car_model }
    it { should have_many :car_feature_car_modifications }
  end

  # it_behaves_like "cars", :car_modification
end

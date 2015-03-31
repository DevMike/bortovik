# == Schema Information
#
# Table name: vehicles
#
#  id                  :integer          not null, primary key
#  car_modification_id :integer
#  engine_volume       :float
#  transmission        :string
#  color               :string
#  mileage             :integer
#  photo_file_name     :string
#  photo_content_type  :string
#  photo_file_size     :integer
#  photo_updated_at    :datetime
#  created_at          :datetime
#  updated_at          :datetime
#  vin                 :string
#  release_year        :integer
#

require 'spec_helper'

describe Vehicle do
  it { should have_many :users }
  it { should have_many :car_feature_car_modifications }
  it { should belong_to :car_modification }
  it { should validate_presence_of :color }
  it { should validate_presence_of :mileage }
  it { should validate_presence_of :car_modification }

  describe "owner" do
    let(:user){ FactoryGirl.create(:user) }
  end
end

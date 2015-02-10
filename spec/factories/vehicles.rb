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

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :vehicle do
    association :car_modification, factory: :car_modification
    engine_volume 2
    transmission "custom"
    color "yellow"
    mileage 1000
  end
end

# == Schema Information
#
# Table name: user_vehicles
#
#  id                  :integer          not null, primary key
#  vehicle_id          :integer
#  user_id             :integer
#  date_of_purchase    :date
#  date_of_sale        :date
#  mileage_on_purchase :integer
#  created_at          :datetime
#  updated_at          :datetime
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user_vehicle
end

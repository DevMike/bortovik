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

class UserVehicle < ActiveRecord::Base
  belongs_to :vehicle
  belongs_to :user

  validates_presence_of :vehicle, :user
  validates_numericality_of :mileage_on_purchase, allow_blank: true
  validates :date_of_purchase, presence: true
end

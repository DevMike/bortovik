class UserVehicle < ActiveRecord::Base
  belongs_to :vehicle
  belongs_to :user
  attr_accessible :date_of_purchase, :date_of_sale, :mileage_on_purchase

  before_save :check_vehicle_owner

  #validates_presence_of :vehicle, :user

  private

  def check_vehicle_owner
    puts "created"
  end
end

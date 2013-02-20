class UserVehicle < ActiveRecord::Base
  belongs_to :vehicle
  belongs_to :user
  attr_accessible :date_of_purchase, :date_of_sale, :mileage_on_purchase
end

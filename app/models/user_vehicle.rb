class UserVehicle < ActiveRecord::Base
  belongs_to :vehicle
  belongs_to :user
  attr_accessible :date_of_purchase, :date_of_sale, :mileage_on_purchase

  validates_presence_of :vehicle, :user
  validates_numericality_of :mileage_on_purchase
  validates :date_of_purchase, format: /^\d{2}\/\d{2}\/\d{4}$/, presence: true
end

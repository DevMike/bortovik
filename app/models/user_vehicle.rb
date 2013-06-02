class UserVehicle < ActiveRecord::Base
  belongs_to :vehicle
  belongs_to :user

  attr_accessible :date_of_purchase, :date_of_sale, :mileage_on_purchase

  validates_presence_of :vehicle, :user
  validates_numericality_of :mileage_on_purchase, allow_blank: true
  validates :date_of_purchase, presence: true
end

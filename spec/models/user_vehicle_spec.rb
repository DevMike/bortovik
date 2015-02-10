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

require 'spec_helper'

describe UserVehicle do
  it { should belong_to :user }
  it { should belong_to :vehicle }
end

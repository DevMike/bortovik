# encoding: UTF-8
# == Schema Information
#
# Table name: settlements
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  region_id  :integer
#  created_at :datetime
#  updated_at :datetime
#


FactoryGirl.define do
  factory :settlement do
    sequence(:name) {|n| "Харьков-#{n}"}
    association :region, :factory=>:region

    factory :default_settlement do
      name "Харьков"
    end
  end
end

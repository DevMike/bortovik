# encoding: UTF-8
# == Schema Information
#
# Table name: regions
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  country_id :integer
#  created_at :datetime
#  updated_at :datetime
#


FactoryGirl.define do
  factory :region do
    sequence(:name) {|n| "Харьковская-#{n}"}
    association :country, :factory=>:country
  end
end

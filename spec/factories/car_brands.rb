# encoding: UTF-8
# == Schema Information
#
# Table name: car_brands
#
#  id          :integer          not null, primary key
#  name        :string
#  created_at  :datetime
#  updated_at  :datetime
#  description :text
#  slug        :string
#

FactoryGirl.define do
  factory :car_brand do
    sequence(:name) {|n| "ВАЗ#{n}"}
  end
end

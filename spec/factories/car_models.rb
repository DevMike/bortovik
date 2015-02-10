# encoding: UTF-8
# == Schema Information
#
# Table name: car_models
#
#  id           :integer          not null, primary key
#  name         :string(255)
#  car_brand_id :integer
#  created_at   :datetime
#  updated_at   :datetime
#  description  :text
#  slug         :string(255)
#


FactoryGirl.define do
  factory :car_model do
    sequence(:name) {|n| "ВАЗ-2101#{n}"}
    association :car_brand, :factory=>:car_brand
  end
end

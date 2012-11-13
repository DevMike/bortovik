# encoding: UTF-8

FactoryGirl.define do
  factory :car_model do
    sequence(:name) {|n| "ВАЗ-2101#{n}"}
    association :car_brand, :factory=>:car_brand
  end
end
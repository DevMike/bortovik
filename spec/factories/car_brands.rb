# encoding: UTF-8

FactoryGirl.define do
  factory :car_brand do
    sequence(:name) {|n| "ВАЗ#{n}"}
  end
end
# encoding: UTF-8

FactoryGirl.define do
  factory :car_modification do
    sequence(:name) {|n| "ВАЗ-2101#{n} TDI"}
    association :car_model, :factory=>:car_model
  end
end
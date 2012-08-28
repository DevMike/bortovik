# encoding: UTF-8

FactoryGirl.define do
  factory :user do
    name 'Иван Иванов'
    sequence(:email) {|n| "user#{n}@example.com" }
    password '123456'
    password_confirmation '123456'
    association :settlement, :factory=>:region
  end
end
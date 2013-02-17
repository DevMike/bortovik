# encoding: UTF-8

FactoryGirl.define do
  factory :user do
    sequence(:name) {|n| "Иван Иванов-#{n}" }
    sequence(:email) {|n| "user#{n}@example.com" }
    password '123456'
    password_confirmation '123456'
    confirmed_at Time.now
    preferred_currency 'UAH'
    agree true
    association :settlement, :factory=>:settlement
  end
end
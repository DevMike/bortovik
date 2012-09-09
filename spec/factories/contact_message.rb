# encoding: UTF-8

FactoryGirl.define do
  factory :contact_message do
    name 'Иван Иванов'
    sequence(:email) { |n| "ivan#{n}@example.com" }
    subject 'Очень срочная проблема!!!'
    description 'Машина поломалась! Помогите!'
  end
end
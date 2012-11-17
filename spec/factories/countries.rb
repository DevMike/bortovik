# encoding: UTF-8

FactoryGirl.define do
  factory :country do
    sequence(:name) {|n| "Украина-#{n}"}
  end
end
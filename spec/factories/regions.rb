# encoding: UTF-8

FactoryGirl.define do
  factory :region do
    sequence(:name) {|n| "Kharvovskaya-#{n}"}
    sequence(:russian_name) {|n| "Харьковская-#{n}"}
    association :country, :factory=>:country
  end
end
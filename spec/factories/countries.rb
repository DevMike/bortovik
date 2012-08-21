# encoding: UTF-8

FactoryGirl.define do
  factory :country do
    sequence(:name) {|n| "Ukraine-#{n}"}
    sequence(:russian_name) {|n| "Украина-#{n}"}
  end
end
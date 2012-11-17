# encoding: UTF-8

FactoryGirl.define do
  factory :settlement do
    sequence(:name) {|n| "Харьков-#{n}"}
    association :region, :factory=>:region
  end
end
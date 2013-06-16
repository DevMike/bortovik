# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :vehicle do
    association :car_modification, factory: :car_modification
    engine_volume 2
    transmission "custom"
    color "yellow"
    mileage 1000
  end
end

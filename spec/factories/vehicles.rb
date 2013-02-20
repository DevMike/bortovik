# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :vehicle do
    car_modification nil
    engine_volume 1
    transmission "MyString"
    color "MyString"
    mileage 1
  end
end

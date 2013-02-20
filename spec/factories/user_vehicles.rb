# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user_vehicle do
    vehicle nil
    user nil
    date_of_purchase "2013-02-20"
    date_of_sale "2013-02-20"
    mileage_on_purchase 1
  end
end

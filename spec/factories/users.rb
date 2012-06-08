# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do |u|
    u.name 'ivan'
    u.email 'ivan@gmail.com'
    u.password '111111'
    u.settlement 1
  end
end
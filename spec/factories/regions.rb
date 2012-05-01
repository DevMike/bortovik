# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :region do
      name "MyString"
      russian_name "MyString"
      country nil
    end
end
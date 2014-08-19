# encoding: UTF-8
# == Schema Information
#
# Table name: car_modifications
#
#  id           :integer          not null, primary key
#  name         :string(255)
#  car_model_id :integer
#  created_at   :datetime
#  updated_at   :datetime
#  description  :text
#  slug         :string(255)
#


FactoryGirl.define do
  factory :car_modification do
    sequence(:name) {|n| "ВАЗ-2101#{n} TDI"}
    association :car_model, :factory=>:car_model
  end
end

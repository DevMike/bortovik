# encoding: UTF-8
# == Schema Information
#
# Table name: countries
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#


FactoryGirl.define do
  factory :country do
    sequence(:name) {|n| "Украина-#{n}"}
  end
end

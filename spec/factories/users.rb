# encoding: UTF-8
# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  name                   :string           not null
#  email                  :string           default("")
#  encrypted_password     :string           default("")
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default("0")
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
#  settlement_id          :integer
#  created_at             :datetime
#  updated_at             :datetime
#  confirmation_token     :string
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  preferred_currency     :string
#  first_name             :string
#  last_name              :string
#  icq                    :string
#  skype                  :string
#  phone                  :string
#  avatar_file_name       :string
#  avatar_content_type    :string
#  avatar_file_size       :integer
#  avatar_updated_at      :datetime
#  provider               :string
#  url                    :string
#  gender                 :string
#  unconfirmed_email      :string
#

FactoryGirl.define do
  factory :user do
    sequence(:name) {|n| "Иван Иванов-#{n}" }
    sequence(:email) {|n| "user#{n}@example.com" }
    password '1234567890'
    password_confirmation '1234567890'
    confirmed_at Time.now
    preferred_currency 'UAH'
    agree true
    association :settlement, :factory=>:settlement
  end
end

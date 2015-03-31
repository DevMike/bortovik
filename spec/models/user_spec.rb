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

require 'spec_helper'

describe User do
  context "attributes" do
    it { should validate_presence_of :settlement_id }
    it { should belong_to :settlement }
    it { should have_many :vehicles }
  end
end

# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  name                   :string(255)      not null
#  email                  :string(255)      default("")
#  encrypted_password     :string(255)      default("")
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  login_as_count          :integer          default(0)
#  current_login_as_at     :datetime
#  last_login_as_at        :datetime
#  current_login_as_ip     :string(255)
#  last_login_as_ip        :string(255)
#  settlement_id          :integer
#  created_at             :datetime
#  updated_at             :datetime
#  confirmation_token     :string(255)
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  preferred_currency     :string(255)
#  first_name             :string(255)
#  last_name              :string(255)
#  icq                    :string(255)
#  skype                  :string(255)
#  phone                  :string(255)
#  avatar_file_name       :string(255)
#  avatar_content_type    :string(255)
#  avatar_file_size       :integer
#  avatar_updated_at      :datetime
#  provider               :string(255)
#  url                    :string(255)
#  gender                 :string(255)
#

require 'spec_helper'

describe User do
  context "attributes" do
    it {should validate_presence_of :settlement_id}
  end
end

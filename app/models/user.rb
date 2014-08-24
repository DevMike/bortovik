# encoding: utf-8
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
#  sign_in_count          :integer          default(0)
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
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


class User < ActiveRecord::Base
  extend Enumerize

  CURRENCIES = %w(UAH RUB EUR USD)
  enumerize :preferred_currency, :in => CURRENCIES
  OUTSIDE_AUTH_SERVICES = %w[facebook vkontakte]
  enumerize :provider, :in => OUTSIDE_AUTH_SERVICES
  GENDERS = %w[автолюбитель автолюбительница]
  enumerize :gender, :in => GENDERS

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable, :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :registerable, :omniauthable#, :confirmable
  #TODO: Enable confirmation.

  # Setup accessible (or protected) attributes for your model
  attr_accessor :agree, :country_id, :region_id, :password_confirmation

  belongs_to :settlement

  scope :confirmed, where("#{table_name}.confirmation_token IS NOT NULL")
  scope :unconfirmed, where(:confirmation_token => nil)

  validates_presence_of :settlement_id, :name
  validates_presence_of :password, :agree, :on => :create, :unless => :create_via_oauth?
  validates_presence_of :password, :on => :update, :unless => :profile_filled?
  validates_confirmation_of :password
  validates_uniqueness_of :name

  delegate :region, :country, :to => :settlement

  after_initialize :assign_default_locations, :unless => :settlement

  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" }

  def full_name
    "#{first_name} #{last_name}"
  end

  class << self
    OUTSIDE_AUTH_SERVICES.each do |service|
      define_method(:"create_or_find_by_#{service}_oauth") do |access_token|
        url = access_token.info.urls.send(service.camelize)
        email = access_token.extra.raw_info.email
        if user = where(['url = ? or email = ?', url, email]).first
          user
        else
          first_name = access_token.info.first_name
          last_name = access_token.info.last_name
          gender = (access_token.extra.raw_info.gender == 'female' || access_token.extra.raw_info.sex != '2') ? GENDERS[1] : GENDERS[0]

          User.create!(provider: access_token.provider,
                       url: access_token.info.urls.send(service.camelize),
                       first_name: first_name,
                       last_name: last_name,
                       name: get_username(access_token, first_name, last_name),
                       email: access_token.extra.raw_info.email,
                       gender: gender,
                       avatar: open(access_token.info.image))
        end
      end
    end

    def get_username(data, first_name, last_name)
      name = [data.info.nickname, data.info.name, data.extra.raw_info.name, [first_name, last_name].compact.join(' ')].detect(&:present?)
      names = pluck(:name)
      if names.include?(name)
        i = 0
        while names.include?(name) do
          i += 1; name = "#{name}-#{i}"
        end
      end
      name
    end
  end

  #check is a user registered via oauth updated his profile or not
  def profile_filled?
    !((created_at.to_s == updated_at.to_s) && provider)
  end

  def create_via_oauth?; provider end

  def confirmation_required?
    super && !create_via_oauth?
  end

protected

  def assign_default_locations
    self.settlement = Settlement.find_by_name(Settings.defaults.settlement)
  end

  def email_required?
    super && !(provider == "vkontakte" && !persisted?)
  end

  def password_required?
    new_record? ? false : super
  end
end

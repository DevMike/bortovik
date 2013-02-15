class User < ActiveRecord::Base
  extend Enumerize
  CURRENCIES = %w(UAH RUB EUR USD)
  enumerize :preferred_currency, :in => CURRENCIES

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :registerable, :confirmable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :name, :email, :password, :password_confirmation, :remember_me, :settlement_id, :preferred_currency, :first_name, :middle_name, :last_name, :icq, :skype, :phone, :avatar

  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" }

  attr_accessor :agree, :country_id, :region_id

  belongs_to :settlement

  scope :confirmed, where("#{table_name}.confirmation_token IS NOT NULL")
  scope :unconfirmed, where(:confirmation_token => nil)

  validates_presence_of :settlement_id, :name
  validates_uniqueness_of :name

  delegate :region, :country, :to => :settlement

  after_initialize :assign_default_locations, :unless => ->{ settlement }

  def full_name
    "#{first_name} #{last_name}"
  end

  class << self
    def current_user
      Thread.current[:current_user]
    end

    def current_user=(user)
      Thread.current[:current_user] = user
    end
  end

  def assign_default_locations
    self.settlement = Settlement.find_by_name(Settings.defaults.settlement)
  end
end

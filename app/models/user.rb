class User < ActiveRecord::Base
  include Enumerize
  CURRENCIES = %w(UAH RUB EUR USD)
  enumerize :preferred_currency, :in => CURRENCIES

  belongs_to :settlement

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :registerable, :confirmable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :name, :email, :password, :password_confirmation, :remember_me, :settlement_id
  attr_accessor :agree, :country_id, :region_id

  validates_presence_of :settlement_id, :name
  validates_uniqueness_of :name

  delegate :region, :country, :to => :settlement

  class << self
    def current_user
      Thread.current[:current_user]
    end

    def current_user=(user)
      Thread.current[:current_user] = user
    end
  end
end

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
  attr_accessor :agree, :country_id, :region_id
  attr_accessible :name, :email, :password, :password_confirmation, :remember_me, :settlement_id, :preferred_currency, :first_name, :middle_name, :last_name, :icq, :skype, :phone, :avatar, :agree

  belongs_to :settlement

  scope :confirmed, where("#{table_name}.confirmation_token IS NOT NULL")
  scope :unconfirmed, where(:confirmation_token => nil)

  validates_presence_of :settlement_id, :name, :agree, :email
  validates_presence_of :password, :password_confirmation, :on => :create
  validates_uniqueness_of :name

  delegate :region, :country, :to => :settlement

  after_initialize :assign_default_locations, :unless => :settlement
  
  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" }

  def assign_default_locations
    self.settlement = Settlement.find_by_name(Settings.defaults.settlement)
  end

  def full_name
    "#{first_name} #{last_name}"
  end
end

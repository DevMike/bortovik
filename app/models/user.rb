class User < ActiveRecord::Base
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
end

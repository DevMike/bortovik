class User < ActiveRecord::Base
  belongs_to :settlement

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :registerable, :confirmable,
         :authentication_keys => [:login]

  # Setup accessible (or protected) attributes for your model
  attr_accessible :login,:name, :email, :password, :password_confirmation, :remember_me, :agree, :settlement
  attr_accessor :login, :agree, :country, :region, :settlement
  validates_presence_of :settlement
end

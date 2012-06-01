class User < ActiveRecord::Base
  belongs_to :settlement

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :authentication_keys => [:login]

  # Setup accessible (or protected) attributes for your model
  attr_accessible :login,:name, :email, :password, :password_confirmation, :remember_me
  attr_accessor :login, :agree, :country
  # attr_accessible :title, :body

  #validates_presence_of :name
  #validates_uniqueness_of :name
  #validates_format_of :email, :with => /^([^\s]+)((?:[-a-z0-9]\.)[a-z]{2,})$/i

  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["lower(name) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    else
      where(conditions).first
    end
  end
end

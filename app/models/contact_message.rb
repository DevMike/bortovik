class ContactMessage
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  attr_accessor :name, :email, :description, :subject

  validates_presence_of :name, :email, :description
  validates_length_of :description, :maximum => 1000
  validates_format_of :email, :with => Devise::email_regexp

  def initialize(attributes=nil)
    if attributes.present?
      [:name, :email, :description, :subject].each do |attr|
        instance_variable_set("@#{attr}", attributes[attr])
      end
    end
  end

  def persisted?; false end
end
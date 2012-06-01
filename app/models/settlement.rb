class Settlement < ActiveRecord::Base
  belongs_to :region
  has_many :users
  attr_accessible :name, :russian_name

  validates :name, :presence => true
  validates :russian_name, :presence => true
end

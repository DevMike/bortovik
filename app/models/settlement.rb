class Settlement < ActiveRecord::Base
  belongs_to :region
  attr_accessible :name, :russian_name

  validates :name, :presence => true
end

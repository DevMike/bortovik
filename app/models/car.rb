class Car < ActiveRecord::Base
  self.abstract_class = true

  attr_accessible :name, :description, :slug

  validates :name, :presence => true
  validates :slug, :presence => true

  before_validation :set_slug, :unless => :slug

  def set_slug; self.slug = name end
end
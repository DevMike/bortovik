class Car < ActiveRecord::Base
  self.abstract_class = true

  attr_accessible :name, :description

  validates :name, :presence => true, :uniqueness => true
  validates :slug, :presence => true, :uniqueness => true

  before_validation :set_slug, :if => ->{ slug.blank? }

  def set_slug; self.slug = name end
end
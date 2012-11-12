class CarBrand < Car
  has_many :car_models, dependent: :destroy

  validates_presence_of :slug

  before_validation :check_slug

  def check_slug
    self.slug = self.name unless slug.present?
  end
end

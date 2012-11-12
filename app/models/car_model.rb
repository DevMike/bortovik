class CarModel < Car
  belongs_to :car_brand
  has_many :car_modifications, dependent: :destroy

  validates_presence_of :slug

  before_validation :check_slug

  def check_slug
    self.slug = self.name unless slug.present?
  end
end

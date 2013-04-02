class CarBrand < Car
  default_scope order(:name)
  has_many :car_models, dependent: :destroy

  validates_uniqueness_of :slug
end

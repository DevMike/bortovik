class CarBrand < Car
  has_many :car_models, dependent: :destroy

  validates_uniqueness_of :slug
end

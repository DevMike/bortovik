class CarBrand < Car
  has_many :car_models, dependent: :destroy
end

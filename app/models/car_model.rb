class CarModel < Car
  belongs_to :car_brand
  has_many :car_modifications, dependent: :destroy
end

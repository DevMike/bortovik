class CarModel < Car
  belongs_to :car_brand
  has_many :car_modifications, dependent: :destroy

  validates_with UniquenessRegardingParentValidator, parent_id_name: :car_brand_id, validated: [:name, :slug]
end

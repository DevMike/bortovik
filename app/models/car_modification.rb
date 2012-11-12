class CarModification < Car
  belongs_to :car_model
  has_many :car_feature_car_modifications, dependent: :destroy
  has_many :car_features, through: :car_feature_car_modifications

  validates_presence_of :slug

  before_validation :check_slug

  delegate :car_brand, :to => :car_model

  search_method :car_brand_eq, :splat_param => true
  def self.car_brand_eq(id)
    joins([:car_model => :car_brand]).where("#{CarBrand.table_name}.id = ?", id)
  end

  def check_slug
    self.slug = self.name unless slug.present?
  end
end

# == Schema Information
#
# Table name: car_brands
#
#  id          :integer          not null, primary key
#  name        :string
#  created_at  :datetime
#  updated_at  :datetime
#  description :text
#  slug        :string
#

class CarBrand < Car
  default_scope { order(:name) }
  has_many :car_models, dependent: :destroy

  validates_uniqueness_of :slug
end

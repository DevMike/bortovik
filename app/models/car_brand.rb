# == Schema Information
#
# Table name: car_brands
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#  description :text
#  slug        :string(255)
#

class CarBrand < Car
  has_many :car_models, dependent: :destroy

  validates_uniqueness_of :slug
end

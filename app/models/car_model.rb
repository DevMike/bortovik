# == Schema Information
#
# Table name: car_models
#
#  id           :integer          not null, primary key
#  name         :string
#  car_brand_id :integer
#  created_at   :datetime
#  updated_at   :datetime
#  description  :text
#  slug         :string
#

class CarModel < Car
  default_scope { order(:name) }
  belongs_to :car_brand
  has_many :car_modifications, dependent: :destroy

  validates_with UniquenessRegardingParentValidator, parent_id_name: :car_brand_id, validated: [:name, :slug]
end

# == Schema Information
#
# Table name: regions
#
#  id         :integer          not null, primary key
#  name       :string
#  country_id :integer
#  created_at :datetime
#  updated_at :datetime
#

class Region < Location
  belongs_to :country
  has_many :settlements, dependent: :destroy

  validates :country_id, presence: true
  validates_with UniquenessRegardingParentValidator, parent_id_name: :country_id, validated: [:name]
end

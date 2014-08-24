# == Schema Information
#
# Table name: settlements
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  region_id  :integer
#  created_at :datetime
#  updated_at :datetime
#

class Settlement < Location
  belongs_to :region
  has_many :users

  validates :region_id, :presence => true
  validates_with UniquenessRegardingParentValidator, parent_id_name: :region_id, validated: [:name]

  delegate :country, :to => :region
end

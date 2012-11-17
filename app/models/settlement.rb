class Settlement < Location
  belongs_to :region
  has_many :users

  validates :region_id, :presence => true
  validates_with UniquenessRegardingParentValidator, parent_id_name: :region_id, validated: [:name]

  delegate :country, :to => :region
end

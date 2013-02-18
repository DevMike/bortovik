class Region < Location
  belongs_to :country
  has_many :settlements, :dependent => :destroy

  validates :country_id, :presence => true
  validates_with UniquenessRegardingParentValidator, parent_id_name: :country_id, validated: [:name]
end

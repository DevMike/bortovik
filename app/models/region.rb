class Region < Location
  belongs_to :country
  has_many :settlements

  validates :country_id, :presence => true
end

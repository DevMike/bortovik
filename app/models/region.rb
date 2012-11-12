class Region < Location
  belongs_to :country
  has_many :settlements
end

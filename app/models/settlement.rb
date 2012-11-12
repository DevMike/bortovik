class Settlement < Location
  belongs_to :region
  has_many :users

  validates :region_id, :presence => true

  delegate :country, :to => :region
end

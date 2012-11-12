class Settlement < Location
  belongs_to :region
  has_many :users

  delegate :country, :to => :region
end

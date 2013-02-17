class Country < Location
  has_many :regions, :dependent => :destroy
end
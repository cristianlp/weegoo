class Event < PointOfInterest
  validates :latitude, :presence => true
  validates :longitude, :presence => true
end

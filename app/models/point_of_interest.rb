class PointOfInterest < ActiveRecord::Base
  belongs_to :category
  belongs_to :sub_category
  
  set_table_name "points_of_interest"
  
  validates :name, :presence => true
  validates :category, :presence => true
  validates :sub_category, :presence => true
  validates :latitude, :presence => true
  validates :longitude, :presence => true
end

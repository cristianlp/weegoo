class PointOfInterestUser < ActiveRecord::Base
  belongs_to :point_of_interest
  belongs_to :user
  
  set_table_name "points_of_interest_users"
end

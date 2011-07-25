class UserVenue < ActiveRecord::Base
  belongs_to :user
  belongs_to :venue
  
  set_table_name 'users_venues'
  
  scope :visited, where('visited = ?', true)
  scope :to_go, where('to_go = ?', true)
  
  def self.mark_as_visited(user, venue)
    user_venue = user.users_venues.find_or_initialize_by_venue_id(venue.id)
    user_venue.update_attributes!({ :visited => true, :to_go => false })
    
    VenueMarkedAsVisitedActivity.create!(:user_a_id => user.id, :venue_id => venue.id)
  end
  
  def self.mark_as_to_go(user, venue)
    user_venue = user.users_venues.find_or_initialize_by_venue_id(venue.id)
    user_venue.update_attributes!({ :visited => false, :to_go => true })
    
    VenueMarkedAsToGoActivity.create!(:user_a_id => user.id, :venue_id => venue.id)
  end
  
  def self.unmark_as_visited(user, venue)
    user.users_venues.visited.find_by_venue_id(venue.id).delete
    
    VenueUnmarkedAsVisitedActivity.create!(:user_a_id => user.id, :venue_id => venue.id)
  end
  
  def self.unmark_as_to_go(user, venue)
    user.users_venues.to_go.find_by_venue_id(venue.id).delete
    
    VenueUnmarkedAsToGoActivity.create!(:user_a_id => user.id, :venue_id => venue.id)
  end
end

class EventUser < ActiveRecord::Base
  belongs_to :event
  belongs_to :user
  
  set_table_name 'events_users'
  
  scope :visited, where('visited = ?', true)
  scope :to_go, where('to_go = ?', true)
  
  def self.mark_as_visited(event, user)
    event_user = user.events_users.find_or_initialize_by_event_id(event.id)
    event_user.update_attributes!({ :visited => true, :to_go => false })
    
    EventMarkedAsVisitedActivity.create!(:user_a_id => user.id, :event_id => event.id)
  end
  
  def self.mark_as_to_go(event, user)
    event_user = user.events_users.find_or_initialize_by_event_id(event.id)
    event_user.update_attributes!({ :visited => false, :to_go => true })
    
    EventMarkedAsToGoActivity.create!(:user_a_id => user.id, :event_id => event.id)
  end
  
  def self.unmark_as_visited(event, user)
    user.events_users.visited.find_by_event_id(event.id).delete
    
    EventUnmarkedAsVisitedActivity.create!(:user_a_id => user.id, :event_id => event.id)
  end
  
  def self.unmark_as_to_go(event, user)
    user.events_users.to_go.find_by_event_id(event.id).delete
    
    EventUnmarkedAsToGoActivity.create!(:user_a_id => user.id, :event_id => event.id)
  end
end

class MainController < ApplicationController
  def index
    if user_signed_in?
      redirect_to current_user
    end
    
    @most_visited_points_of_interest = PointOfInterest.most_visited
    @most_active_users = User.most_active
    @upcoming_events = Event.upcoming
  end
  
  def about
  end
  
  def contribute
  end
end

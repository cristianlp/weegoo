class MainController < ApplicationController
  def index
    if user_signed_in?
      redirect_to current_user and return
    end
    
    if is_mobile_request?
      redirect_to new_user_session_url and return
    end
    
    @most_visited_venues = Venue.most_visited
    @most_active_users = User.most_active
    @upcoming_events = Event.upcoming
  end
  
  def about
  end
  
  def contribute
  end
  
  def search
    @users = User.search(params[:query]).page(1).per(User::PER_PAGE)
    @venues = Venue.search(params[:query]).page(1).per(Venue::PER_PAGE)
    @events = Event.search(params[:query]).page(1).per(Event::PER_PAGE)
  end
  
  def upcoming_events
    @upcoming_events = Event.upcoming
  end
end

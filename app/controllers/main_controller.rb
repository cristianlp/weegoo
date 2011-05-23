class MainController < ApplicationController
  def index
    if user_signed_in?
      redirect_to current_user
    end
    
    @most_visited_points_of_interest = PointOfInterest.most_visited
  end
  
  def about
  end
end

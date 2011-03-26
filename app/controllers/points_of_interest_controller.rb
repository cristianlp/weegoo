class PointsOfInterestController < ApplicationController
  before_filter :authenticate_user!, :except => [:index]
  
  def index
    if params[:search]
      @points_of_interest = PointOfInterest.search(params[:search]).page(params[:page]).per(5)
    else
      @points_of_interest = []
    end
    
    # without this, kaminari won't work (with this specific model):
    @points_of_interest.each { |p| }
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @points_of_interest }
    end
  end
  
  def been
    @point_of_interest = PointOfInterest.find(params[:id])
    
    point_of_interest_user = current_user.points_of_interest_users.find_or_initialize_by_point_of_interest_id(@point_of_interest.id)
    point_of_interest_user.update_attributes(:been => true, :want_to_go => false)
    
    respond_to do |format|
      format.js do
        # flash[:notice] is not used because it persists between requests
        @message = "You've been at #{@point_of_interest.name}."
        render :response
      end
    end
  end
  
  def want_to_go
    @point_of_interest = PointOfInterest.find(params[:id])
    
    current_user.points_of_interest_users.create!(:point_of_interest_id => @point_of_interest.id, :want_to_go => true)
    
    respond_to do |format|
      format.js do
        # flash[:notice] is not used because it persists between requests
        @message = "You want to go to #{@point_of_interest.name}."
        render :response
      end
    end
  end
end

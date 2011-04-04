class PointsOfInterestController < ApplicationController
  before_filter :authenticate_user!, :except => [:index, :show, :been_users, :want_to_go_users]
  
  def index
    if params[:search]
      @points_of_interest = PointOfInterest.search(params[:search], params[:type]).page(params[:page]).per(5)
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
  
  def show
    @point_of_interest = PointOfInterest.find_by_permalink(params[:permalink])
  end
  
  def been
    @point_of_interest = PointOfInterest.find_by_permalink(params[:permalink])
    
    PointOfInterestUser.been(@point_of_interest, current_user)
    
    respond_to do |format|
      format.js do
        render :partial => "points_of_interest/point_of_interest_actions", :locals => { :point_of_interest => @point_of_interest }
      end
    end
  end
  
  def not_been
    @point_of_interest = PointOfInterest.find_by_permalink(params[:permalink])
    
    PointOfInterestUser.not_been(@point_of_interest, current_user)
    
    respond_to do |format|
      format.js do
        render :partial => "points_of_interest/point_of_interest_actions", :locals => { :point_of_interest => @point_of_interest }
      end
    end
  end
  
  def want_to_go
    @point_of_interest = PointOfInterest.find_by_permalink(params[:permalink])
    
    PointOfInterestUser.want_to_go(@point_of_interest, current_user)
    
    respond_to do |format|
      format.js do
        render :partial => "points_of_interest/point_of_interest_actions", :locals => { :point_of_interest => @point_of_interest }
      end
    end
  end
  
  def dont_want_to_go
    @point_of_interest = PointOfInterest.find_by_permalink(params[:permalink])
    
    PointOfInterestUser.dont_want_to_go(point_of_interest, user)
    
    respond_to do |format|
      format.js do
        render :partial => "points_of_interest/point_of_interest_actions", :locals => { :point_of_interest => @point_of_interest }
      end
    end
  end
  
  def been_users
    @point_of_interest = PointOfInterest.find_by_permalink(params[:permalink])
    
    @users = @point_of_interest.been_users.page(params[:page]).per(5)
  end
  
  def want_to_go_users
    @point_of_interest = PointOfInterest.find_by_permalink(params[:permalink])
    
    @users = @point_of_interest.want_to_go_users.page(params[:page]).per(5)
  end
  
  # arreglar estos dos metodos
  def been_friends
    @point_of_interest = PointOfInterest.find_by_permalink(params[:permalink])
    
    @users = @point_of_interest.been_friends(current_user).page(params[:page]).per(5)
  end
  
  def want_to_go_friends
    @point_of_interest = PointOfInterest.find_by_permalink(params[:permalink])
    
    @users = @point_of_interest.want_to_go_friends(current_user).page(params[:page]).per(5)
  end
end

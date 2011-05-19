class PointsOfInterestController < ApplicationController
  before_filter :authenticate_user!, :except => [:index, :show, :been_users, :want_to_go_users]
  
  def index
    if params[:search]
      @points_of_interest = PointOfInterest.search(params[:search], params[:type]).page(params[:page]).per(PointOfInterest::PER_PAGE)
    else
      @points_of_interest = []
    end
    
    # without this, kaminari won't work (with this specific model):
    @points_of_interest.each { |p| }
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @points_of_interest }
      format.js
    end
  end
  
  def show
    @point_of_interest = PointOfInterest.find_by_permalink(params[:id])
  end
  
  def been
    @point_of_interest = PointOfInterest.find_by_permalink(params[:id])
    
    PointOfInterestUser.been(@point_of_interest, current_user)
    
    respond_to do |format|
      format.html { redirect_to(@point_of_interest, :notice => t('controllers.points_of_interest.been', :point_of_interest => @point_of_interest)) }
    end
  end
  
  def not_been
    @point_of_interest = PointOfInterest.find_by_permalink(params[:id])
    
    PointOfInterestUser.not_been(@point_of_interest, current_user)
    
    respond_to do |format|
      format.html { redirect_to(@point_of_interest, :notice => t('controllers.points_of_interest.not_been', :point_of_interest => @point_of_interest)) }
    end
  end
  
  def want_to_go
    @point_of_interest = PointOfInterest.find_by_permalink(params[:id])
    
    PointOfInterestUser.want_to_go(@point_of_interest, current_user)
    
    respond_to do |format|
      format.html { redirect_to(@point_of_interest, :notice => t('controllers.points_of_interest.want_to_go', :point_of_interest => @point_of_interest)) }
    end
  end
  
  def dont_want_to_go
    @point_of_interest = PointOfInterest.find_by_permalink(params[:id])
    
    PointOfInterestUser.dont_want_to_go(@point_of_interest, current_user)
    
    respond_to do |format|
      format.html { redirect_to(@point_of_interest, :notice => t('controllers.points_of_interest.dont_want_to_go', :point_of_interest => @point_of_interest)) }
    end
  end
  
  def been_users
    @point_of_interest = PointOfInterest.find_by_permalink(params[:id])
    
    @users = @point_of_interest.been_users.page(params[:page]).per(User::PER_PAGE)
    
    respond_to do |format|
      format.html
      format.xml  { render :xml => @users }
      format.js  { render :partial => "points_of_interest/users_pagination", :locals => { :users => @users } }
    end
  end
  
  def want_to_go_users
    @point_of_interest = PointOfInterest.find_by_permalink(params[:id])
    
    @users = @point_of_interest.want_to_go_users.page(params[:page]).per(User::PER_PAGE)
    
    respond_to do |format|
      format.html
      format.xml  { render :xml => @users }
      format.js  { render :partial => "points_of_interest/users_pagination", :locals => { :users => @users } }
    end
  end
  
  # arreglar estos dos metodos
  def been_friends
    @point_of_interest = PointOfInterest.find_by_permalink(params[:id])
    
    @users = @point_of_interest.been_friends(current_user).page(params[:page]).per(User::PER_PAGE)
    
    respond_to do |format|
      format.html
      format.xml  { render :xml => @users }
      format.js  { render :partial => "points_of_interest/users_pagination", :locals => { :users => @users } }
    end
  end
  
  def want_to_go_friends
    @point_of_interest = PointOfInterest.find_by_permalink(params[:id])
    
    @users = @point_of_interest.want_to_go_friends(current_user).page(params[:page]).per(User::PER_PAGE)
    
    respond_to do |format|
      format.html
      format.xml  { render :xml => @users }
      format.js  { render :partial => "points_of_interest/users_pagination", :locals => { :users => @users } }
    end
  end
end

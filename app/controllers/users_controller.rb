class UsersController < ApplicationController
  def index
    if params[:search]
      @users = User.search(params[:search]).page(params[:page]).per(5)
    else
      @users = []
    end
    
    # without this, kaminari won't work (with this specific model):
    @users.each { |u| }
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @users }
      format.js
    end
  end

  def show
    @user = User.find_by_username(params[:username])
    
    @activities = @user.related_activities.page(params[:page]).per(5)
    
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @user }
      format.js
    end
  end

  def add_as_friend
    @user = User.find_by_username(params[:username])
    @another_user = User.find_by_username(params[:another_user_username])
    
    current_user.friendships.create!(:user_b_id => @another_user.id)
    
    respond_to do |format|
      format.js do
        render :partial => "users/user_desc_actions", :locals => { :user => @another_user }
      end
    end
  end
  
  def cancel_friendship_request
    @user = User.find_by_username(params[:username])
    @another_user = User.find_by_username(params[:another_user_username])
    
    friendship = current_user.friendships.where("user_b_id = ?", @another_user.id)
    current_user.friendships.delete(friendship)
    
    respond_to do |format|
      format.js do
        render :partial => "users/user_desc_actions", :locals => { :user => @another_user }
      end
    end
  end
  
  def accept_friendship
    @user = User.find_by_username(params[:username])
    
    @friendship = Friendship.find(params[:friendship_id])
    @friendship.accept
    
    respond_to do |format|
      format.js do
        render :partial => "users/friendship_actions", :locals => { :user => @user, :friendship => @friendship }
      end
    end
  end
  
  def decline_friendship
    @user = User.find_by_username(params[:username])
    
    @friendship = Friendship.find(params[:friendship_id])
    @friendship.delete
    
    respond_to do |format|
      format.js do
        render :partial => "users/friendship_actions", :locals => { :user => @user, :friendship => @friendship }
      end
    end
  end
  
  def friendship_requests
    @user = User.find_by_username(params[:username])
    
    @pending_friendships = @user.pending_friendships.page(params[:page]).per(5)
    
    respond_to do |format|
      format.html
      format.xml  { render :xml => @pending_friendships }
      format.js
    end
  end
  
  def friends
    @user = User.find_by_username(params[:username])
    
    @accepted_friendships = @user.accepted_friendships.page(params[:page]).per(5)
    
    respond_to do |format|
      format.html
      format.xml  { render :xml => @accepted_friendships }
      format.js
    end
  end
  
  def mutual_friends
    @user = User.find_by_username(params[:username])
    
    @mutual_friends = @user.mutual_friends(current_user).page(params[:page]).per(5)
    
    respond_to do |format|
      format.html
      format.xml  { render :xml => @mutual_friends }
      format.js
    end
  end
  
  def visited_places
    @user = User.find_by_username(params[:username])
    
    params[:type] ||= "Everything"
    params[:show_as] ||= "List"
    
    if params[:type] != "Everything"
      @been_points_of_interest = @user.been_points_of_interest.where("type = ?", params[:type]).page(params[:page]).per(5)
    else
      @been_points_of_interest = @user.been_points_of_interest.page(params[:page]).per(5)
    end
    
    respond_to do |format|
      format.html
      format.xml  { render :xml => @been_points_of_interest }
      format.js  { render :partial => "users/points_of_interest_pagination", :locals => { :points_of_interest => @been_points_of_interest } }
    end
  end
  
  def places_to_go
    @user = User.find_by_username(params[:username])
    
    params[:type] ||= "Everything"
    params[:show_as] ||= "List"
    
    if params[:type] != "Everything"
      @want_to_go_points_of_interest = @user.want_to_go_points_of_interest.where("type = ?", params[:type]).page(params[:page]).per(5)
    else
      @want_to_go_points_of_interest = @user.want_to_go_points_of_interest.page(params[:page]).per(5)
    end
    
    respond_to do |format|
      format.html
      format.xml  { render :xml => @been_points_of_interest }
      format.js  { render :partial => "users/points_of_interest_pagination", :locals => { :points_of_interest => @want_to_go_points_of_interest } }
    end
  end
end

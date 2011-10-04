class UsersController < ApplicationController
  before_filter :authenticate_user!, :except => [ :index, :show, :friends, :visited_venues, :venues_to_go, :visited_events, :events_to_go ]
  
  # GET /users
  # GET /users.json
  def index
    if params[:query]
      @users = User.search(params[:query]).page(params[:page]).per(User::PER_PAGE)
    else
      @users = []
    end
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @users }
      format.js { render :partial => 'users/pagination', :locals => { :users => @users } }
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find_by_username!(params[:id])
    @activities = @user.related_activities.page(params[:page]).per(Activity::PER_PAGE)
    
    @most_visited_venues = Venue.most_visited
    @most_active_users = User.most_active
    @upcoming_events = Event.upcoming
    
    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @user }
      format.js { render :partial => 'activities/pagination', :locals => { :activities => @activities, :user => @user } }
    end
  end
  
  def add_as_friend
    @user = User.find_by_username(params[:id])
    @another_user = User.find_by_username(params[:another_user_id])
    
    @user.friendships.create!(:user_b_id => @another_user.id)
    
    respond_to do |format|
      format.html { render :partial => 'users/user', :locals => { :user => @another_user } }
    end
  end
  
  def cancel_friendship_request
    @user = User.find_by_username(params[:id])
    @another_user = User.find_by_username(params[:another_user_id])
    
    friendship = @user.friendships.where('user_b_id = ?', @another_user.id)
    @user.friendships.delete(friendship)
    
    respond_to do |format|
      format.html { render :partial => 'users/user', :locals => { :user => @another_user } }
    end
  end
  
  def delete_friendship
    @user = User.find_by_username(params[:id])
    @another_user = User.find_by_username(params[:another_user_id])
    
    friendship = @user.friendships.where('user_b_id = ?', @another_user.id).first
    if not friendship.nil?
      @user.friendships.delete(friendship)
    else
      friendship = @another_user.friendships.where('user_b_id = ?', @user.id).first
      @another_user.friendships.delete(friendship)
    end
    
    respond_to do |format|
      format.html { render :partial => 'users/user', :locals => { :user => @another_user } }
    end
  end
  
  def accept_friendship
    @user = User.find_by_username(params[:id])
    
    @friendship = Friendship.find(params[:friendship_id])
    @friendship.accept
    
    respond_to do |format|
      format.html { render :partial => 'users/user', :locals => { :user => @friendship.friend(@user) } }
    end
  end
  
  def decline_friendship
    @user = User.find_by_username(params[:id])
    
    @friendship = Friendship.find(params[:friendship_id])
    @friendship.delete
    
    respond_to do |format|
      format.html { render :partial => 'users/user', :locals => { :user => @friendship.friend(@user) } }
    end
  end
  
  def friends
    @user = User.find_by_username(params[:id])
    
    @accepted_friendships = @user.accepted_friendships.page(params[:page]).per(User::PER_PAGE)
    
    respond_to do |format|
      format.html
      format.json { render :json => @accepted_friendships }
      format.js { render :partial => 'friendships/pagination', :locals => { :friendships => @accepted_friendships, :user => @user } }
    end
  end
  
  def pending_friendships
    @user = User.find_by_username(params[:id])
    @pending_friendships = @user.pending_friendships.page(params[:page]).per(User::PER_PAGE)
    
    redirect_to root_url unless current_user == @user and @pending_friendships.size > 0
    
    respond_to do |format|
      format.html
      format.json { render :json => @pending_friendhips }
      format.js { render :partial => 'friendships/pagination', :locals => { :friendships => @pending_friendships, :user => @user } }
    end
  end
  
  def mutual_friends
    @user = User.find_by_username(params[:id])
    
    @mutual_friends = @user.mutual_friends(current_user).page(params[:page]).per(User::PER_PAGE)
    
    respond_to do |format|
      format.html
      format.json  { render :json => @mutual_friends }
      format.js { render :partial => 'users/pagination', :locals => { :users => @mutual_friends } }
    end
  end

  
  def find_friends
    @user = User.find_by_username(params[:id])
    
    if params[:provider] == 'facebook'
      @friends = @user.facebook_friends
    elsif params[:provider] == 'twitter'
      @friends = @user.twitter_friends
    end
    
    if @friends.size > 0
      @friends = @friends.page(params[:page]).per(User::PER_PAGE)
    end
    
    respond_to do |format|
      format.html
      format.json  { render :json => @friends }
      format.js { render :partial => 'users/pagination', :locals => { :users => @users } }
    end
  end
  
  def visited_venues
    @user = User.find_by_username(params[:id])
    @venues = @user.visited_venues.page(params[:page]).per(Venue::PER_PAGE)
    
    @title = t 'views.users.user_visited_venues', :user => @user.full_name
    @current_user_no_venues_message = t 'views.users.you_have_not_visited_any_venue'
    @no_venues_message = t 'views.users.user_has_not_visited_any_venue', :user => @user.full_name
    
    params[:show_as] ||= 'List'
        
    respond_to do |format|
      format.html { render 'venues' }
      format.js { render :partial => 'venues/pagination', :locals => { :venues => @venues } }
    end
  end
  
  def venues_to_go
    @user = User.find_by_username(params[:id])
    @venues = @user.venues_to_go.page(params[:page]).per(Venue::PER_PAGE)
    
    @title = t 'views.users.user_venues_to_go', :user => @user.full_name
    @current_user_no_venues_message = t 'views.users.you_have_no_venue_to_go'
    @no_venues_message = t 'views.users.user_has_no_venue_to_go', :user => @user.full_name
    
    params[:show_as] ||= 'List'
    
    respond_to do |format|
      format.html { render 'venues' }
      format.js { render :partial => 'venues/pagination', :locals => { :venues => @venues } }
    end
  end
  
  def visited_events
    @user = User.find_by_username(params[:id])
    @events = @user.visited_events.page(params[:page]).per(Event::PER_PAGE)
    
    @title = t 'views.users.user_visited_events', :user => @user.full_name
    @current_user_no_events_message = t 'views.users.you_have_not_visited_any_event'
    @no_events_message = t 'views.users.user_has_not_visited_any_event', :user => @user.full_name
    
    respond_to do |format|
      format.html { render 'events' }
      format.js { render :partial => 'events/pagination', :locals => { :events => @events } }
    end
  end
  
  def events_to_go
    @user = User.find_by_username(params[:id])
    @events = @user.events_to_go.page(params[:page]).per(Event::PER_PAGE)
    
    @title = t 'views.users.user_events_to_go', :user => @user.full_name
    @current_user_no_events_message = t 'views.users.you_have_no_event_to_go'
    @no_events_message = t 'views.users.user_has_no_event_to_go', :user => @user.full_name
    
    respond_to do |format|
      format.html { render 'events' }
      format.js { render :partial => 'events/pagination', :locals => { :events => @events } }
    end
  end
end

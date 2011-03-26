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
    end
  end

  def show
    @user = User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @user }
    end
  end

  def add_as_friend
    @user = User.find(params[:id])
    @another_user = User.find(params[:another_user_id])
    
    current_user.friendships.create!(:user_b_id => @another_user.id)
    
    respond_to do |format|
      format.js do
        # flash[:notice] is not used because it persists between requests
        @message = "Friendship requested to #{@another_user.full_name} successfully."
      end
    end
  end
  
  def accept_friendship
    @user = User.find(params[:id])
    
    @friendship = Friendship.find(params[:friendship_id])
    @friendship.accept
    
    respond_to do |format|
      format.js do
        # flash[:notice] is not used because it persists between requests
        @message = "You and #{@friendship.user_a.full_name} are now friends."
        render "friendship_response"
      end
    end
  end
  
  def decline_friendship
    @user = User.find(params[:id])
    
    @friendship = Friendship.find(params[:friendship_id])
    @friendship.delete
    
    respond_to do |format|
      format.js do
        # flash[:notice] is not used because it persists between requests
        @message = "You and #{@friendship.user_a.full_name} are not friends."
        render "friendship_response"
      end
    end
  end
  
  def friendship_requests
    @user = User.find(params[:id])
    
    @friendship_requests = @user.pending_friendships.page(params[:page]).per(5)
  end
  
  def friends
    @user = User.find(params[:id])
    
    @accepted_friendships = @user.accepted_friendships.page(params[:page]).per(5)
  end
  
  def visited_places
    @user = User.find(params[:id])
    
    @been_points_of_interest = @user.been_points_of_interest.page(params[:page]).per(5)
  end
  
  def places_to_go
    @user = User.find(params[:id])
    
    @want_to_go_points_of_interest = @user.want_to_go_points_of_interest.page(params[:page]).per(5)
  end
end

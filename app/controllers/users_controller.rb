class UsersController < ApplicationController
  def index
    if params[:search]
      @users = User.search(params[:search])
    else
      @users = []
    end
    
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
  end
  
  def friends
    @user = User.find(params[:id])
  end
end

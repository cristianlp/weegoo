class MainController < ApplicationController
  def index
    if user_signed_in?
      render "dashboard"
    end
  end
  
  def friendship_requests
  end
  
  def friends
  end
end

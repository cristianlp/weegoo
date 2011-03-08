class DashboardController < ApplicationController
  def index
    @friendship_requests = current_user.pending_friendships
  end
end

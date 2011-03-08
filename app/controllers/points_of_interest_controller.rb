class PointsOfInterestController < ApplicationController
  def index
    if params[:search]
      @points_of_interest = PointOfInterest.search(params[:search])
    else
      @points_of_interest = []
    end
  end
end

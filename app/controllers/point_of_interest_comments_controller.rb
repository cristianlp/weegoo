class PointOfInterestCommentsController < ApplicationController
  before_filter :find_point_of_interest
  
  # GET /point_of_interest_comments
  # GET /point_of_interest_comments.xml
  def index
    @point_of_interest_comments = @point_of_interest.point_of_interest_comments

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @point_of_interest_comments }
    end
  end

  # POST /point_of_interest_comments
  # POST /point_of_interest_comments.xml
  def create
    @point_of_interest_comment = @point_of_interest.point_of_interest_comments.create(params[:point_of_interest_comment])
    @point_of_interest_comment.user = current_user

    respond_to do |format|
      if @point_of_interest_comment.save
        format.html { redirect_to(points_of_interest_point_of_interest_comments_path(@point_of_interest), :notice => 'Point of interest comment was successfully created.') }
        format.xml  { render :xml => @point_of_interest_comment, :status => :created, :location => @point_of_interest_comment }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @point_of_interest_comment.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /point_of_interest_comments/1
  # DELETE /point_of_interest_comments/1.xml
  def destroy
    @point_of_interest_comment = PointOfInterestComment.find(params[:id])
    @point_of_interest_comment.destroy

    respond_to do |format|
      format.html { redirect_to(point_of_interest_comments_url) }
      format.xml  { head :ok }
    end
  end
  
  protected
  
  def find_point_of_interest
    @point_of_interest = PointOfInterest.find_by_permalink(params[:points_of_interest_id])
  end
end

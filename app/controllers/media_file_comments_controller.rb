class MediaFileCommentsController < ApplicationController
  before_filter :find_objects
  
  # GET /media_file_comments
  # GET /media_file_comments.xml
  def index
    @media_file_comments = @media_file.media_file_comments

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @media_file_comments }
    end
  end

  # POST /media_file_comments
  # POST /media_file_comments.xml
  def create
    # set the user_id in the params, so when the comment is created, the user it's already created
    params[:media_file_comment][:user_id] = current_user.id
    @media_file_comment = @media_file.media_file_comments.create(params[:media_file_comment])

    respond_to do |format|
      if @media_file_comment.save
        format.html { redirect_to(points_of_interest_media_file_media_file_comments_path(@point_of_interest, @media_file), :notice => 'Media file comment was successfully created.') }
        format.xml  { render :xml => @media_file_comment, :status => :created, :location => @media_file_comment }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @media_file_comment.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /media_file_comments/1
  # DELETE /media_file_comments/1.xml
  def destroy
    @media_file_comment = MediaFileComment.find(params[:id])
    @media_file_comment.destroy

    respond_to do |format|
      format.html { redirect_to(media_file_comments_url) }
      format.xml  { head :ok }
    end
  end
  
  private
  
  def find_objects
    @point_of_interest = PointOfInterest.find_by_permalink(params[:points_of_interest_id])
    @media_file = @point_of_interest.media_files.find(params[:media_file_id])
  end
end

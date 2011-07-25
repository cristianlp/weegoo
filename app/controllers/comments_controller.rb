class CommentsController < ApplicationController
  before_filter :authenticate_user!, :except => [ :index ]
  before_filter :find_commentable
  
  # GET /comments
  # GET /comments.json
  def index
    @comments = @commentable.comments
    @comment = Comment.new

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @comments }
    end
  end

  # POST /comments
  # POST /comments.json
  def create
    @comments = @commentable.comments
    @comment = @commentable.comments.build(params[:comment])
    @comment.user = current_user
    
    respond_to do |format|
      if @comment.save
        if @commentable.class.to_s == 'Venue'
          format.html { redirect_to :id => nil }
        elsif @commentable.class.to_s == 'Event'
          format.html { redirect_to venue_event_comments_url(@commentable.venue, @commentable) }
        elsif @commentable.class.to_s == 'Image'
          if @commentable.imageable.respond_to?(:venue)
            format.html { redirect_to venue_event_image_url(@commentable.imageable.venue, @commentable.imageable, @commentable) }
          else
            format.html { redirect_to venue_image_url(@commentable.imageable, @commentable) }
          end
        end
        format.json { render :json => @comment, :status => :created, :location => @comment }
      else
        format.html { render :action => 'index' }
        format.json { render :json => @comment.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    @comments = @commentable.comments
    @comment = Comment.find(params[:id])
    @comment.destroy
    
    respond_to do |format|
      if @commentable.class.to_s == 'Venue'
        format.html { redirect_to :controller => 'comments', :action => 'index', :id => @commentable.id }
      elsif @commentable.class.to_s == 'Event'
        format.html { redirect_to venue_event_comments_url(@commentable.venue, @commentable) }
      else
        if @commentable.imageable.respond_to?(:venue)
          format.html { redirect_to venue_event_image_url(@commentable.imageable.venue, @commentable.imageable, @commentable) }
        else
          format.html { redirect_to venue_image_url(@commentable.imageable, @commentable) }
        end
      end
      format.json { head :ok }
    end
  end
  
  protected
  
  def find_commentable
    @commentable = nil
    
    # this can't be done because of the order (AND the nesting)
    #
    #params.each do |name, value|
    #  if name =~ /(.+)_id$/
    #    @commentable = $1.classify.constantize.find_by_permalink(value)
    #  end
    #end
    
    # so:
    if params.include?(:image_id)
      @commentable = Image.find(params[:image_id])
    elsif params.include?(:event_id)
      @commentable = Event.find_by_permalink(params[:event_id])
    elsif params.include?(:venue_id)
      @commentable = Venue.find_by_permalink(params[:venue_id])
    end
  end
end

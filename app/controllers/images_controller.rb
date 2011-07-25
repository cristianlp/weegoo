class ImagesController < ApplicationController
  before_filter :authenticate_user!, :except => [ :index, :show ]
  before_filter :find_commentable
  
  # GET /images
  # GET /images.json
  def index
    @images = @imageable.images
    @image = Image.new

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @images }
    end
  end
  
  def show
    @image = @imageable.images.find(params[:id])
    @comments = @image.comments
    
    respond_to do |format|
      format.html
      format.json { render :json => @image }
    end
  end

  # POST /images
  # POST /images.json
  def create
    @images = @imageable.images
    @image = @imageable.images.build(params[:image])
    @image.user = current_user

    respond_to do |format|
      if @image.save
        if @imageable.class.to_s == 'Venue'
          format.html { redirect_to :id => nil }
        else
          format.html { redirect_to venue_event_images_path(@imageable.venue, @imageable) }
        end
        format.json { render :json => @image, :status => :created, :location => @image }
      else
        format.html { render :action => 'index' }
        format.json { render :json => @image.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /images/1
  # DELETE /images/1.json
  def destroy
    @images = @imageable.images
    @image = Image.find(params[:id])
    @image.destroy

    respond_to do |format|
      if @imageable.class.to_s == 'Venue'
        format.html { redirect_to :controller => 'images', :action => 'index', :id => @imageable.id }
      else
        format.html { redirect_to venue_event_images_path(@imageable.venue, @imageable) }
      end
      format.json { head :ok }
    end
  end
  
  protected
  
  def find_commentable
    @imageable = nil
    
    # this can't be done because of the order (AND the nesting)
    #
    #params.each do |name, value|
    #  if name =~ /(.+)_id$/
    #    @commentable = $1.classify.constantize.find_by_permalink(value)
    #  end
    #end
    
    # so:
    if params.include?(:event_id)
      @imageable = Event.find_by_permalink(params[:event_id])
    elsif params.include?(:venue_id)
      @imageable = Venue.find_by_permalink(params[:venue_id])
    end
  end
end

class VenuesController < ApplicationController
  before_filter :authenticate_user!, :except => [ :index, :show, :visitors, :possible_visitors ]
  
  # GET /venues
  # GET /venues.json
  def index
    if params[:query]
      if is_mobile_request?
        @venues = Venue.find_with_ferret(params[:query])
      else
        # this is because find_with_ferret is not a scope and we use kaminari to display the results
        @venues = Kaminari.paginate_array(Venue.find_with_ferret(params[:query], { :page => 1, :per_page => 999 })).page(params[:page]).per(Venue::PER_PAGE)
      end
    else
      @venues = []
    end
    
    params[:show_as] ||= 'List'
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @venues }
      format.js { render :partial => 'venues/pagination', :locals => { :venues => @venues } }
    end
  end

  # GET /venues/1
  # GET /venues/1.json
  def show
    @venue = Venue.find_by_permalink!(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @venue }
    end
  end

  # GET /venues/new
  # GET /venues/new.json
  def new
    @venue = Venue.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @venue }
    end
  end

  # GET /venues/1/edit
  def edit
    @venue = Venue.find_by_permalink(params[:id])
  end

  # POST /venues
  # POST /venues.json
  def create
    @venue = Venue.new(params[:venue])
    @venue.user = current_user

    respond_to do |format|
      if @venue.save
        format.html { redirect_to @venue, :notice => t('views.venues.venue_was_successfully_created') }
        format.json { render :json => @venue, :status => :created, :location => @venue }
      else
        format.html { render :action => "new" }
        format.json { render :json => @venue.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /venues/1
  # PUT /venues/1.json
  def update
    @venue = Venue.find_by_permalink(params[:id])

    respond_to do |format|
      if @venue.update_attributes(params[:venue])
        format.html { redirect_to @venue, :notice => t('views.venues.venue_was_successfully_updated') }
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @venue.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /venues/1
  # DELETE /venues/1.json
  def destroy
    @venue = Venue.find_by_permalink(params[:id])
    @venue.destroy

    respond_to do |format|
      format.html { redirect_to venues_url }
      format.json { head :ok }
    end
  end
  
  def mark_as_visited
    @venue = Venue.find_by_permalink(params[:id])
    
    UserVenue.mark_as_visited current_user, @venue
    
    respond_to do |format|
      format.html do
        if request.xml_http_request?
          render :partial => 'venues/venue', :locals => { :venue => @venue }
        else
          redirect_to @venue
        end
      end
    end
  end
  
  def mark_as_to_go
    @venue = Venue.find_by_permalink(params[:id])
    
    UserVenue.mark_as_to_go current_user, @venue
    
    respond_to do |format|
      format.html do
        if request.xml_http_request?
          render :partial => 'venues/venue', :locals => { :venue => @venue }
        else
          redirect_to @venue
        end
      end
    end
  end
  
  def unmark_as_visited
    @venue = Venue.find_by_permalink(params[:id])
    
    UserVenue.unmark_as_visited current_user, @venue
    
    respond_to do |format|
      format.html do
        if request.xml_http_request?
          render :partial => 'venues/venue', :locals => { :venue => @venue }
        else
          redirect_to @venue
        end
      end
    end
  end
  
  def unmark_as_to_go
    @venue = Venue.find_by_permalink(params[:id])
    
    UserVenue.unmark_as_to_go current_user, @venue
    
    respond_to do |format|
      format.html do
        if request.xml_http_request?
          render :partial => 'venues/venue', :locals => { :venue => @venue }
        else
          redirect_to @venue
        end
      end
    end
  end
  
  def visitors
    @venue = Venue.find_by_permalink(params[:id])
    @users = @venue.visitors.page(params[:page]).per(User::PER_PAGE)
    
    @title = t 'views.venues.venue_visitors', :venue => @venue.name
    @no_users_message = t 'views.venues.venue_has_no_visitors', :venue => @venue.name
    
    respond_to do |format|
      format.html { render 'users' }
      format.json { render :json => @users }
      format.js { render :partial => 'users/pagination', :locals => { :users => @users } }
    end
  end
  
  def possible_visitors
    @venue = Venue.find_by_permalink(params[:id])
    @users = @venue.possible_visitors.page(params[:page]).per(User::PER_PAGE)
    
    @title = t 'views.venues.venue_possible_visitors', :venue => @venue.name
    @no_users_message = t 'views.venues.venue_has_no_possible_visitors', :venue => @venue.name
    
    respond_to do |format|
      format.html { render 'users' }
      format.json { render :json => @users }
      format.js { render :partial => 'users/pagination', :locals => { :users => @users } }
    end
  end
  
  def browse_categories
    @categories = Category.all
    
    respond_to do |format|
      format.html
      format.json { render :json => @categories }
    end
  end
  
  def browse_sub_categories
    @category = Category.find(params[:category_id])
    @sub_categories = @category.sub_categories
    
    respond_to do |format|
      format.html
      format.json { render :json => @sub_categories }
    end
  end
  
  def map
    @venues = Venue.all
    
    respond_to do |format|
      format.html { render 'index' }
      format.json { render :json => @venues }
    end
  end
  
  def category_map
    @category = Category.find(params[:category_id])
  
    @venues = @category.venues
    
    respond_to do |format|
      format.html { render 'index' }
      format.json { render :json => @venues }
    end
  end
  
  def sub_category_map
    @sub_category = SubCategory.find(params[:sub_category_id])
  
    @venues = @sub_category.venues
    
    respond_to do |format|
      format.html { render 'index' }
      format.json { render :json => @venues }
    end
  end
end

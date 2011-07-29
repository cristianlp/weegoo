class EventsController < ApplicationController
  before_filter :authenticate_user!, :except => [ :show, :visitors, :possible_visitors ]
  before_filter :find_venue
  
  # GET /events
  # GET /events.json
  def index
    @events = @venue.events.page(params[:page]).per(Event::PER_PAGE)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @events }
      format.js { render :partial => 'events/pagination', :locals => { :events => @events } }
    end
  end

  # GET /events/1
  # GET /events/1.json
  def show
    @event = @venue.events.find_by_permalink(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @event }
    end
  end

  # GET /events/new
  # GET /events/new.json
  def new
    @event = Event.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @event }
    end
  end

  # GET /events/1/edit
  def edit
    @event = @venue.events.find_by_permalink(params[:id])
  end

  # POST /events
  # POST /events.json
  def create
    @event = @venue.events.build(params[:event])
    @event.user = current_user

    respond_to do |format|
      if @event.save
        format.html { redirect_to [@venue, @event], :notice => t('views.events.event_was_successfully_created') }
        format.json { render :json => @event, :status => :created, :location => @event }
      else
        format.html { render :action => "new" }
        format.json { render :json => @event.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /events/1
  # PUT /events/1.json
  def update
    @event = @venue.events.find_by_permalink(params[:id])

    respond_to do |format|
      if @event.update_attributes(params[:event])
        format.html { redirect_to [@venue, @event], :notice => t('views.events.event_was_successfully_updated') }
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @event.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event = @venue.events.find(params[:id])
    @event.destroy

    respond_to do |format|
      format.html { redirect_to events_url }
      format.json { head :ok }
    end
  end
  
  def mark_as_visited
    @event = @venue.events.find_by_permalink(params[:id])
    
    EventUser.mark_as_visited @event, current_user
    
    respond_to do |format|
      format.html do
        if request.xml_http_request?
          render :partial => 'events/event', :locals => { :event => @event }
        else
          redirect_to [@venue, @event]
        end
      end
    end
  end
  
  def mark_as_to_go
    @event = @venue.events.find_by_permalink(params[:id])
    
    EventUser.mark_as_to_go @event, current_user
    
    respond_to do |format|
      format.html do
        if request.xml_http_request?
          render :partial => 'events/event', :locals => { :event => @event }
        else
          redirect_to [@venue, @event]
        end
      end
    end
  end
  
  def unmark_as_visited
    @event = @venue.events.find_by_permalink(params[:id])
    
    EventUser.unmark_as_visited @event, current_user
    
    respond_to do |format|
      format.html do
        if request.xml_http_request?
          render :partial => 'events/event', :locals => { :event => @event }
        else
          redirect_to [@venue, @event]
        end
      end
    end
  end
  
  def unmark_as_to_go
    @event = @venue.events.find_by_permalink(params[:id])
    
    EventUser.unmark_as_to_go @event, current_user
    
    respond_to do |format|
      format.html do
        if request.xml_http_request?
          render :partial => 'events/event', :locals => { :event => @event }
        else
          redirect_to [@venue, @event]
        end
      end
    end
  end
  
  def visitors
    @event = @venue.events.find_by_permalink(params[:id])
    @users = @event.visitors.page(params[:page]).per(User::PER_PAGE)
    
    @title = t 'views.events.event_visitors', :event => @event.name
    @no_users_message = t 'views.events.event_has_no_visitors', :event => @event.name
    
    respond_to do |format|
      format.html { render 'users' }
      format.json { render :json => @users }
      format.js { render :partial => 'users/pagination', :locals => { :users => @users } }
    end
  end
  
  def possible_visitors
    @event = @venue.events.find_by_permalink(params[:id])
    @users = @event.possible_visitors.page(params[:page]).per(User::PER_PAGE)
    
    @title = t 'views.events.event_possible_visitors', :event => @event.name
    @no_users_message = t 'views.events.event_has_no_possible_visitors', :event => @event.name
    
    respond_to do |format|
      format.html { render 'users' }
      format.json { render :json => @users }
      format.js { render :partial => 'users/pagination', :locals => { :users => @users } }
    end
  end
  
  protected
  
  def find_venue
    @venue = Venue.find_by_permalink(params[:venue_id])
  end
end

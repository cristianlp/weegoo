class EventsController < ApplicationController
  before_filter :authenticate_user!, :except => [:show]
  
  # GET /events/1
  # GET /events/1.xml
  def show
    @event = Event.find_by_permalink(params[:id])

    redirect_to points_of_interest_url(@event)
  end

  # GET /events/new
  # GET /events/new.xml
  def new
    @event = Event.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @event }
    end
  end

  # GET /events/1/edit
  def edit
    @event = Event.find_by_permalink(params[:id])
  end

  # POST /events
  # POST /events.xml
  def create
    @event = Event.new(params[:event])
    @event.user = current_user

    respond_to do |format|
      if @event.save
        format.html { redirect_to(@event, :notice => t('controllers.events.created')) }
        format.xml  { render :xml => @event, :status => :created, :location => @event }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @event.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /events/1
  # PUT /events/1.xml
  def update
    @event = Event.find_by_permalink(params[:id])

    respond_to do |format|
      if @event.update_attributes(params[:event])
        format.html { redirect_to(@event, :notice => t('controllers.events.updated')) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @event.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.xml
  def destroy
    @event = Event.find_by_permalink(params[:id])
    @event.destroy

    respond_to do |format|
      format.html { redirect_to(points_of_interest_index_url) }
      format.xml  { head :ok }
    end
  end
end

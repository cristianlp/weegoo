class MediaFilesController < ApplicationController
  before_filter :find_point_of_interest
  
  # GET /media_files
  # GET /media_files.xml
  def index
    @media_files = @point_of_interest.media_files.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @media_files }
    end
  end

  # GET /media_files/new
  # GET /media_files/new.xml
  def new
    @media_file = @point_of_interest.media_files.build

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @media_file }
    end
  end

  # GET /media_files/1/edit
  def edit
    @media_file = MediaFile.find(params[:id])
  end

  # POST /media_files
  # POST /media_files.xml
  def create
    # set the user_id in the params, so when the media file is created, the user it's already created
    params[:media_file][:user_id] = current_user.id
    @media_file = @point_of_interest.media_files.create(params[:media_file])

    respond_to do |format|
      if @media_file.save
        format.html { redirect_to(points_of_interest_media_files_path(@point_of_interest), :notice => 'Media file was successfully created.') }
        format.xml  { render :xml => @media_file, :status => :created, :location => @media_file }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @media_file.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /media_files/1
  # PUT /media_files/1.xml
  def update
    @media_file = MediaFile.find(params[:id])

    respond_to do |format|
      if @media_file.update_attributes(params[:media_file])
        format.html { redirect_to(points_of_interest_media_files_path(@point_of_interest), :notice => 'Media file was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @media_file.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /media_files/1
  # DELETE /media_files/1.xml
  def destroy
    @media_file = MediaFile.find(params[:id])
    @media_file.destroy

    respond_to do |format|
      format.html { redirect_to(points_of_interest_media_files_url(@point_of_interest)) }
      format.xml  { head :ok }
    end
  end
  
  protected
  
  def find_point_of_interest
    @point_of_interest = PointOfInterest.find_by_permalink(params[:points_of_interest_id])
  end
end

class CheckinsController < ApplicationController
  
  include Geokit::Geocoders
  
  def index
    @checkins = current_user.checkins

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @posts }
    end
  end
  
  def show
    
  end
  
  def new
    @checkin = Checkin.new
  end
  
  def create
    @checkin = Checkin.new(params[:checkin])
    
    #current_user.checkins.push(checkin)
  end
  
  def venue_search
    if params[:name] && params[:address]
      @name = params[:name]
      @address = params[:address]
      res = MultiGeocoder.geocode(@address)
      foursquare = Foursquare::Base.new(current_user.access_code.code)
      @venues = foursquare.venues.search(
        :query => @name, 
        #:near => @address,
        :ll => res.ll,
        :llAcc => "1")
    end
  end
  
  def set_time
    
  end
  
  def edit
    
  end
  
  def update
    
  end
  
  def destroy
    checkin = Checkin.find(params[:id])
    checkin.destroy

    respond_to do |format|
      format.html { redirect_to checkins_url }
      format.json { head :no_content }
    end
  end
  
end

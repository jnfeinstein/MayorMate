class CheckinsController < ApplicationController
  
  include Geokit::Geocoders
  include CheckinsHelper
  include UsersHelper

  #before_filter :check_user
  
  def check_user
    if get_user.nil?
      redirect_to root_url
    end
  end
  
  def index
    @checkins = get_user.checkins
  end
  
  def show
    @checkin = Checkin.find(params[:id])
  end
  
  def new
    checkin = Checkin.new
    checkin.venue_id = params[:venue_id]
    checkin.time = "#{params[:date][:hour]}:#{params[:date][:minute]}"
    schedule_checkin(checkin)
    get_user.checkins.push(checkin) 
    redirect_to checkins_url
  end
  
  def venue_search
    if params[:name] && params[:address]
      @name = params[:name]
      @address = params[:address]
      res = MultiGeocoder.geocode(@address)
      foursquare = Foursquare::Base.new(get_user.access_token)
      @venues = foursquare.venues.search(
        :query => @name, 
        #:near => @address,
        :ll => res.ll,
        :llAcc => 1)
    end
  end
  
  def set_time
    @venue_id = params[:venue_id]
  end
  
  def destroy
    checkin = Checkin.find(params[:id])
    unschedule_checkin(checkin)
    get_user.checkins.delete(checkin)
    checkin.destroy
    redirect_to checkins_url
  end
  
end

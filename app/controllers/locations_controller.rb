class LocationsController < ApplicationController
  
  include Geokit::Geocoders
  
  def to_address
    res = GoogleGeocoder.reverse_geocode("#{params[:lat]},#{params[:long]}")
    Rails.logger.debug(res)
    render :json => res.full_address
  end
  
  def to_gps
    
  end
  
end

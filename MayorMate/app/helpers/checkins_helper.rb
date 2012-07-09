module CheckinsHelper
  
  include Geokit::Geocoders
  include UsersHelper
  
  @@scheduler = Rufus::Scheduler.start_new 
    
  def get_checkin_venue(checkin)
    foursquare = Foursquare::Base.new(checkin.user.access_token)
    return foursquare.venues.find(checkin.venue_id)
  end
  
  def get_venue_address(venue)
    loc = venue.location
    return "#{loc.address}, #{loc.city}, #{loc.state}"
  end
  
  def get_venue_gps_ll(venue)
    address = get_venue_address(venue)
    res = MultiGeocoder.geocode(address)
    return res.ll
  end
  
  def perform_checkin(checkin)
    foursquare = Foursquare::Base.new(checkin.user.access_token)
    venue = get_checkin_venue(checkin)
    foursquare.checkins.add(
      :venueId => checkin.venue_id, 
      :ll => get_venue_gps_ll(venue),
      :llAcc => 1,
      :broadcast => "public")
    checkin.count += 1
    checkin.save
  end
  
  def schedule_checkin(checkin)
    job = @@scheduler.every '1d', :first_at => Chronic.parse(checkin.time) do
      perform_checkin(checkin)
    end
    checkin.job_id = job.job_id
    checkin.save
  end
  
  def schedule_all_checkins
    Checkin.all.each do |checkin|
      schedule_checkin(checkin)
    end
  end
  
  def get_scheduled_job(checkin)
    return @@scheduler.find(checkin.job_id)
  end
  
  def unschedule_checkin(checkin)
    @@scheduler.unschedule(checkin.job_id)
  end
  
  # Startup
  schedule_all_checkins
end

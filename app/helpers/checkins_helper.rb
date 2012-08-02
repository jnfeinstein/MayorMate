module CheckinsHelper
  
  include Geokit::Geocoders
  include UsersHelper
  
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
  
  def schedule_checkin(checkin)
    #Chronic.time_class = ActiveSupport::TimeZone.create(checkin.time_zone)
    #time = Chronic.parse("#{checkin.time}")
    #job = Delayed::Job.enqueue(ScheduledCheckin.new(checkin), :run_at => time)
    #checkin.job_id = job.id
    #checkin.save
    ScheduledCheckin.new(checkin)
  end
  
  def get_scheduled_job(checkin)
    return Delayed::Job.find_by_id(checkin.job_id)
  end
  
  def unschedule_checkin(checkin)
    job = get_scheduled_job(checkin)
    if !job.nil?
      get_scheduled_job(checkin).destroy
    end
  end
  
end

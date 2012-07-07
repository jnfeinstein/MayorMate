module CheckinsHelper
  
  def get_checkin_venue(checkin)
    foursquare = Foursquare::Base.new(current_user.access_code.code)
    return foursquare.venues.find(checkin.venue_id)
  end
  
  def get_venue_address(venue)
    loc = venue.location
    return "#{loc.address}, #{loc.city}, #{loc.state}"
  end
  
  def perform_checkin(checkin)
    foursquare = Foursquare::Base.new(current_user.access_code.code)
    foursquare.checkins.add(:venueId => checkin.venue_id, :broadcast => "public")
    checkin.count += 1
  end
  
  def schedule_checkin(checkin)
    job = $scheduler.every '1d', :first_at => Chronic.parse(checkin.time) do
    #job = $scheduler.every '30s' do
      logger.debug "Checking in to #{checkin.venue_id}"
      perform_checkin(checkin)
    end
    checkin.job_id = job.job_id
  end
  
  def unschedule_checkin(checkin)
    $scheduler.unschedule(checkin.job_id)
  end
end

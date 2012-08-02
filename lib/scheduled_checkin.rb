class ScheduledCheckin
  
  include ScheduledJob
  include CheckinsHelper
    
  attr_accessor :checkin
  
  run_every 1.day
  
  def initialize(checkin)
    @checkin = checkin
    schedule_checkin
  end
  
  def schedule_checkin
    Chronic.time_class = ActiveSupport::TimeZone.create(@checkin.time_zone)
    time = Chronic.parse("#{@checkin.time}")
    schedule! time
  end
  
  def perform
    foursquare = Foursquare::Base.new(@checkin.user.access_token)
    venue = get_checkin_venue(@checkin)
    foursquare.checkins.add(
      :venueId => @checkin.venue_id, 
      :ll => get_venue_gps_ll(venue),
      :llAcc => 1,
      :broadcast => "public")
    @checkin.count += 1
    @checkin.save
  end
  
  def just_scheduled!
    @checkin.job_id = @job.id
    @checkin.save
  end
  
end
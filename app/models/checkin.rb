class Checkin < ActiveRecord::Base
  belongs_to :user
  attr_accessible :count, :job_id, :time_zone, :time, :user, :venue_id
end

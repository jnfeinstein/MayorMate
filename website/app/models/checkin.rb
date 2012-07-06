class Checkin < ActiveRecord::Base
  belongs_to :user
  attr_accessible :enabled, :time, :venue
end

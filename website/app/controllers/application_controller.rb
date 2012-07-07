class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter:authenticate_user!
  $scheduler = Rufus::Scheduler.start_new 
end

# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
MayorMate::Application.initialize!

config.after_initialize do
  include CheckinsHelper
  schedule_all_checkins
end
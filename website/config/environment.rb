# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Website::Application.initialize!

config.after_initialize do
  CheckinsHelper.schedule_all_checkins
end
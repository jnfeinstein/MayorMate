Delayed::Worker.destroy_failed_jobs = true
#Delayed::Worker.logger = Rails.logger
Delayed::Worker.logger = Logger.new(File.join(Rails.root, 'log', 'dj.log'))
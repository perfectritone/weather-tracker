require 'json'
require 'sidekiq/api'
require_relative '../weather_worker'

desc "Weather tracker"
task :weather_tracker do
  ss = Sidekiq::ScheduledSet.new
  jobs = ss.select {|job| job.klass == 'WeatherWorker' }
  jobs.each(&:delete)

  config_raw_json = File.read('config/zipcodes_to_track.json')
  config = JSON.parse(config_raw_json)

  config.each do |c|
    WeatherWorker.perform_in(c["every"], c["zipcode"], c["every"])
  end
end

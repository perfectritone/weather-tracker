require 'json'
require 'sidekiq/api'
require_relative '../weather_worker'

desc "Weather tracker"
task :weather_tracker do
  ss = Sidekiq::ScheduledSet.new
  jobs = ss.select {|job| job.klass == 'WeatherWorker' }
  jobs.each(&:delete)

  read_config.each do |c|
    WeatherWorker.perform_in(c["every"], c["zipcode"], c["every"])
  end
end


def read_config
  begin
    config_raw_json = File.read('config/zipcodes_to_track.json')
    JSON.parse(config_raw_json)
  rescue
    puts "JSON file 'config/zipcodes_to_track.json' is not valid."
    exit
  end
end

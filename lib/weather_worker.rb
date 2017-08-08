require 'sidekiq'
require_relative 'weather_tracker'

# If your client is single-threaded, we just need a single connection in our Redis connection pool
Sidekiq.configure_client do |config|
  config.redis = { :size => 1 }
end

# Sidekiq server is multi-threaded so our Redis connection pool size defaults to concurrency (-c)
Sidekiq.configure_server do |config|
  config.redis = { }
end

# Start up sidekiq via
# ./bin/sidekiq -r ./examples/por.rb
# and then you can open up an IRB session like so:
# irb -r ./examples/por.rb
# where you can then say
# PlainOldRuby.perform_async "like a dog", 3
#
class WeatherWorker
  include Sidekiq::Worker
  sidekiq_options queue: 'weather_tracker'

  def perform(zipcode, every=nil)
    WeatherTracker.new.track(zipcode)
    puts zipcode
    self.class.perform_in(every, zipcode, every) if every
  end
end

require 'sequel'
require_relative 'weather_service'

class WeatherTracker

  def track(zipcode)
    weather = WeatherService.new.get_weather(zipcode)

    weather_attrs = [:name, :zipcode, :general_condition,
                     :atmospheric_pressure, :temperature_f, :wind_speed,
                     :wind_direction, :humidity, :timestamp]

    self.class.db[:weather_data].insert(
      weather_attrs.each_with_object({}) { |e, h| h[e] = weather[e] }.merge(
        created_at: Time.now,
        updated_at: Time.now,
      )
    )
  end

  def self.db
    @@db ||= Sequel.connect(database_url)
  end

  private

  def self.database_url
    ENV['WEATHER_TRACKER_DATABASE_URL'] || 'sqlite://weather_tracker.sqlite3'
  end
end

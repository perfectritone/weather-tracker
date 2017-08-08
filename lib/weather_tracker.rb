require 'sequel'
require_relative 'weather_service'

class WeatherTracker

  attr_reader :db

  def track(zipcode)
    weather = WeatherService.new.get_weather(zipcode)

    weather_attrs = [:name, :zipcode, :general_condition,
                     :atmospheric_pressure, :temperature_f, :wind_speed,
                     :wind_direction, :humidity, :timestamp]

    db[:weather_data].insert(
      weather_attrs.each_with_object({}) { |e, h| h[e] = weather[e] }.merge(
        created_at: Time.now,
        updated_at: Time.now,
      )
    )
  end

  def db
    @db ||= Sequel.connect(database_url)
  end

  private

  def database_url
    ENV['WEATHER_TRACKER_DATABASE_URL'] || 'sqlite://weather_tracker.sqlite3'
  end
end

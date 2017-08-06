require 'unirest'
require 'dotenv/load'

class WeatherService

  def get_weather(zipcode)
    response = Unirest.get "http://api.openweathermap.org/data/2.5/weather",
      parameters: {
        zip: "#{zipcode},us",
        APPID: ENV['OPEN_WEATHER_MAP_API_KEY'],
      }

    body = response.body
    timestamp = Time.at(body['dt'])

    {
      name: response.body['name'],
      zipcode: zipcode,
      general_condition: body['weather'][0]['main'],
      atmospheric_pressure: body['main']['pressure'],
      temperature_f: body['main']['temp'],
      wind_speed: body['wind']['speed'],
      wind_direction: body['wind']['deg'],
      humidity: body['main']['humidity'],
      timestamp: timestamp,
    }
  end
end

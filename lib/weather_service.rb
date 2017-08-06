require 'unirest'

class WeatherService

  def get_weather(zipcode)
    response = Unirest.get "http://api.openweathermap.org/data/2.5/weather",
      parameters: {
        zipcode: zipcode,
      }

    {
      name: response.body['name'],
    }
  end
end

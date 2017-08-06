require 'weather_service'

describe WeatherService do

  describe '#get_weather' do
    let(:zipcode) { 28753 }

    it 'should return the name for a given zipcode' do
      expect(described_class.new.get_weather(zipcode)).to include :name
    end

    it 'should return a variety of relevant weather info' do
      expect(described_class.new.get_weather(zipcode)).to include(
        :name,
        :zipcode,
        :general_condition,
        :atmospheric_pressure,
        :temperature_f,
        :wind_speed,
        :wind_direction,
        :humidity,
        :timestamp,
      )
    end

    it 'should return the temperature in fahrenheit' do
      # < 150 will most likely not be Kelvin
      expect(described_class.new.get_weather(zipcode)[:temperature_f]).to be < 150
    end
  end
end

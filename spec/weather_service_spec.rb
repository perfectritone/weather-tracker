require 'weather_service'

describe WeatherService do

  describe '#get_weather' do
    it 'should return the weather for a given zipcode' do
      zipcode = 28753

      expect(described_class.new.get_weather(zipcode)).to include :name
    end
  end
end

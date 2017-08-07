require 'weather_tracker'

describe WeatherTracker do

  describe '#track' do
    let(:zipcode) { 28753 }

    it 'should get the weather and store it in the db' do
      expect{described_class.new.track(zipcode)}.
        to change{described_class.new.db[:weather_data].count}.by 1
    end
  end
end

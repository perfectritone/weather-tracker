# Setup

To run, ensure you've add a .env file with an OPEN_WEATHER_MAP_API_KEY
This key can be obtained from https://openweathermap.org/appid

## Development

Update config/zipcodes_to_track.json with zipcodes and intervals each should be
checked in seconds

Run `sqlite3 weather_tracker.sqlite3` to setup the database
Run `rake db:migrate` to migrate database

Run `rake weather_tracker` to setup jobs

Ensure that Redis is running locally

Run sidekiq
`bundle exec sidekiq -r ./lib/weather_worker.rb -q weather_tracker`

## Test
Run `sqlite3 weather_tracker_test.sqlite3` to setup the test database
Run `WEATHER_TRACKER_DATABASE_URL=sqlite://weather_tracker_test.sqlite3 rake db:migrate` to migrate test database

Run `rspec`

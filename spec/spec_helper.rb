require 'database_cleaner'
require 'sequel'

ENV['WEATHER_TRACKER_DATABASE_URL'] = 'sqlite://weather_tracker_test.sqlite3'

RSpec.configure do |config|
  DatabaseCleaner[
    :sequel,
    {
      connection: Sequel.connect(ENV['WEATHER_TRACKER_DATABASE_URL'])
    }
  ]

  config.before(:suite) do
    DatabaseCleaner[:sequel].strategy = :transaction
    DatabaseCleaner[:sequel].clean_with(:truncation)
  end

  config.around(:each) do |example|
    DatabaseCleaner[:sequel].cleaning do
      example.run
    end
  end
end

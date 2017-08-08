require_relative '../weather_tracker'

namespace :db do
  desc "Run migrations"
  task :migrate, [:version, :gem_root] do |_, args|
    run_migrations(version: args[:version])
  end
end

def run_migrations(version:nil)
  require "sequel"

  Sequel.extension :migration

  db = WeatherTracker.db

  migration_dir = File.join(Dir.pwd, 'db', 'migrate')

  if version
    puts "Migrating to version #{version}"
    Sequel::Migrator.run(db, migration_dir, target: version.to_i)
  else
    puts "Migrating to latest"
    Sequel::Migrator.run(db, migration_dir)
  end
end

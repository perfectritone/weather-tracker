Sequel.migration do
  change do
    add_column :weather_data, :created_at, Time
    add_column :weather_data, :updated_at, Time
  end
end

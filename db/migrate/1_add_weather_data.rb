Sequel.migration do
  change do
    create_table(:weather_data) do
      primary_key :id
      String      :name
      String      :zipcode
      String      :general_condition
      Integer     :atmospheric_pressure
      Float 			:temperature_f
      Float 			:wind_speed
      Float 			:wind_direction
      Integer			:humidity
      Time			  :timestamp
    end
  end
end

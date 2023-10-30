# Convert the start and stop times to hourly resolution
divvy_df$date_from <- floor_date(mdy_hms(divvy_df$`START TIME`), "hour")
divvy_df$date_to <- floor_date(mdy_hms(divvy_df$`STOP TIME`), "hour")

# Rename columns for ease of reference
divvy_df <- divvy_df %>%
  rename(
    from_station_id = `FROM STATION ID`,
    from_latitude = `FROM LATITUDE`,
    from_longitude = `FROM LONGITUDE`,
    to_station_id = `TO STATION ID`,
    to_latitude = `TO LATITUDE`,
    to_longitude = `TO LONGITUDE`
  )

# Aggregate by start time and location to compute daily start trips
from_trips_hourly <- divvy_df %>%
  group_by(date_from, from_station_id, from_latitude, from_longitude) %>%
  summarize(hourly_from_trips = n(), .groups = "drop")

# Aggregate by stop time and location to compute daily stop trips
to_trips_houlry <- divvy_df %>%
  group_by(date_to, to_station_id, to_latitude, to_longitude) %>%
  summarize(hourly_to_trips = n(), .groups = "drop")

# Merge start and stop trips by time and location
hourly_trips <- left_join(from_trips_hourly, to_trips_houlry, 
                         by = c("date_from" = "date_to", 
                                "from_station_id" = "to_station_id",
                                "from_latitude" = "to_latitude",
                                "from_longitude" = "to_longitude")) %>%
  transmute(
    date = date_from,
    station_id = from_station_id,
    latitude = from_latitude,
    longitude = from_longitude,
    hourly_from_trips = replace_na(hourly_from_trips, 0),
    hourly_to_trips = replace_na(hourly_to_trips, 0),
    net_trips = hourly_to_trips - hourly_from_trips,
    day = day(date),
    month = month(date)
  ) %>%
  drop_na(latitude) %>%
  # Convert the data to spatial format
  st_as_sf(coords = c("longitude", "latitude"), crs = 4269)

# Add lag terms and day and month columns
houlry_trips <- hourly_trips %>%
  mutate(lagHour_to = dplyr::lag(hourly_to_trips, 1),
           lag2Hours_to = dplyr::lag(hourly_to_trips, 2),
           lag3Hours_to = dplyr::lag(hourly_to_trips, 3),
           lag4Hours_to = dplyr::lag(hourly_to_trips, 4),
           lag12Hours_to = dplyr::lag(hourly_to_trips, 12),
           lag1day_to = dplyr::lag(hourly_to_trips, 24), 
         
         lagHour_from = dplyr::lag(hourly_from_trips, 1),
         lag2Hours_from = dplyr::lag(hourly_from_trips, 2),
         lag3Hours_from = dplyr::lag(hourly_from_trips, 3),
         lag4Hours_from = dplyr::lag(hourly_from_trips, 4),
         lag12Hours_from = dplyr::lag(hourly_from_trips, 12),
         lag1day_from = dplyr::lag(hourly_from_trips, 24)
         ) %>%
  # Drop rows with no pervious lags
  drop_na(lag1day_to) %>%
  mutate(day = day(date), month = month(date))
  

# Convert rail stops data to spatial format
rail_stops_sf <- rail_stops %>%
  st_as_sf(coords = c("location.longitude", "location.latitude"), 
           crs = 4269)

# Calculate the distance to the nearest rail stop for each trip location
daily_trips$distance_to_rail <- apply(st_distance(daily_trips, rail_stops_sf), 1, min)

# Join the trips data with the population data using spatial join
daily_trips_pop <-  st_join(daily_trips, cook_population, join = st_within) %>%
  select(-c(NAME, variable, GEOID)) %>%
  rename(Population = value)

# Create hourly weather panel
weather.Panel <-  
  weather.Data %>%
  mutate(date = floor_date(valid, "hour")) %>%
  group_by(date) %>%
  summarize(
    HighTemp = ifelse(all(is.na(tmpf)), NA, max(tmpf, na.rm = TRUE)),
    LowTemp = ifelse(all(is.na(tmpf)), NA, min(tmpf, na.rm = TRUE)),
    Percipitation = sum(p01i, na.rm = TRUE),
    Wind_Speed = ifelse(all(is.na(sknt)), NA, max(sknt, na.rm = TRUE))) %>%
  arrange(date) %>%
  # Replace NA values with values from the previous hour
  fill(HighTemp, LowTemp, Percipitation, Wind_Speed, .direction = "down")

daily_trips_full <- left_join(daily_trips_pop, weather.Panel)


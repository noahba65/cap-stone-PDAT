divvy_df$date_from <- as.Date(divvy_df$start_time)
divvy_df$date_to <- as.Date(divvy_df$stop_time)

from_trips_daily <- divvy_df %>%
  group_by(date_from, from_station_id, from_latitude, from_longitude) %>%
  summarize(daily_from_trips = n(), .groups = "drop")
to_trips_daily <- divvy_df %>%
  group_by(date_to, to_station_id, to_latitude, to_longitude) %>%
  summarize(daily_to_trips = n(), .groups = "drop")
daily_trips <- left_join(from_trips_daily, to_trips_daily, 
                         by = c("date_from" = "date_to", 
                                "from_station_id" = "to_station_id")) %>%
  transmute(
    date = date_from,
    station_id = from_station_id,
    latitude = from_latitude,
    longitude = from_longitude,
    daily_from_trips = replace_na(daily_from_trips, 0),
    daily_to_trips = replace_na(daily_to_trips, 0),
    net_trips = daily_from_trips - daily_to_trips
  ) %>%
  st_as_sf(coords = c("longitude", "latitude"), crs = 4269)


rail_stops <- rail_stops %>%
  st_as_sf(coords = c("location.longitude", "location.latitude"), 
           crs = 4326)


daily_trips_pop <-  st_join(daily_trips, cook_population, join = st_within) %>%
  select(-c(NAME, variable, GEOID)) %>%
  rename(Population = value)



weather.Panel <-  
  weather.Data %>%
  mutate(date = as.Date(valid) ) %>%
  group_by(date) %>%
  summarize(HighTemp = max(tmpf, na.rm = T),
            LowTemp = min(tmpf, na.rm = T),
            Percipitation = sum(p01i, na.rm = T),
            Wind_Speed = max(sknt, na.rm = T))

daily_trips_full <- left_join(daily_trips_pop, weather.Panel)
head(daily_trips_full)


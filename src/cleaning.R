
divvy_df$date_from <- floor_date(mdy_hms(divvy_df$`START TIME`), "hour")
divvy_df$date_to <- floor_date(mdy_hms(divvy_df$`STOP TIME`), "hour")


divvy_df <- divvy_df %>%
  rename(
    from_station_id = `FROM STATION ID`,
    from_latitude = `FROM LATITUDE`,
    from_longitude = `FROM LONGITUDE`,
    to_station_id = `TO STATION ID`,
    to_latitude = `TO LATITUDE`,
    to_longitude = `TO LONGITUDE`
  )


from_trips_daily <- divvy_df %>%
  group_by(date_from, from_station_id, from_latitude, from_longitude) %>%
  summarize(daily_from_trips = n(), .groups = "drop")

to_trips_daily <- divvy_df %>%
  group_by(date_to, to_station_id, to_latitude, to_longitude) %>%
  summarize(daily_to_trips = n(), .groups = "drop")

daily_trips <- left_join(from_trips_daily, to_trips_daily, 
                         by = c("date_from" = "date_to", 
                                "from_station_id" = "to_station_id",
                                "from_latitude" = "to_latitude",
                                "from_longitude" = "to_longitude")) %>%
  transmute(
    date = date_from,
    station_id = from_station_id,
    latitude = from_latitude,
    longitude = from_longitude,
    daily_from_trips = replace_na(daily_from_trips, 0),
    daily_to_trips = replace_na(daily_to_trips, 0),
    net_trips = daily_to_trips - daily_from_trips,
    day = day(date),
    month = month(date)
  ) %>%
  drop_na(latitude) %>%
  st_as_sf(coords = c("longitude", "latitude"), crs = 4269)

rail_stops_sf <- rail_stops %>%
  st_as_sf(coords = c("location.longitude", "location.latitude"), 
           crs = 4269)

daily_trips$distance_to_rail <- apply(st_distance(daily_trips, rail_stops_sf), 1, min)


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

weather.Panel <-  
  weather.Data %>%
  mutate(hourly_time = floor_date(valid, "hour")) %>%
  group_by(hourly_time) %>%
  summarize(HighTemp = max(tmpf, na.rm = TRUE),
            LowTemp = min(tmpf, na.rm = TRUE),
            Percipitation = sum(p01i, na.rm = TRUE),
            Wind_Speed = max(sknt, na.rm = TRUE))


weather.Panel <-  
  weather.Data %>%
  mutate(hourly_time = floor_date(valid, "hour")) %>%
  group_by(hourly_time) %>%
  summarize(HighTemp = max(tmpf, na.rm = TRUE),
            LowTemp = min(tmpf, na.rm = TRUE),
            Percipitation = sum(p01i, na.rm = TRUE),
            Wind_Speed = max(sknt, na.rm = TRUE)) %>%
  mutate(HighTemp = ifelse(HighTemp == -Inf, NA, HighTemp),
         LowTemp = ifelse(LowTemp == Inf, NA, LowTemp)) %>%
  arrange(hourly_time) %>%
  fill(HighTemp, LowTemp, Percipitation, Wind_Speed, .direction = "down")

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
  fill(HighTemp, LowTemp, Percipitation, Wind_Speed, .direction = "down")

daily_trips_full <- left_join(daily_trips_pop, weather.Panel)


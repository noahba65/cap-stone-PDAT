
chicago_ca_clean <- chicago_ca_raw %>%
  st_transform(4269) %>%
  filter(pri_neigh %in% target_ca) 

divvy_stations_clean <- divvy_stations_raw %>%
  st_as_sf(coords = c("longitude", "latitude"), crs = 4269)

# Join data frames to identity stations in target community areas
divvy_stations_in_ca <- st_join(chicago_ca_clean, divvy_stations_clean) 

id_filter <- divvy_stations_in_ca$id

# Clean divvy data 
divvy_10_min_clean <- divvy_raw %>%
  rename(available_docks = `Available Docks`, docks_in_service = `Docks in Service`) %>%
  filter( ID %in% id_filter) %>%
  mutate(deficit = as.numeric(available_docks) - as.numeric(docks_in_service)) %>%
  select(Timestamp, ID, deficit) %>%
  mutate(Timestamp = as.POSIXct(Timestamp, format = "%m/%d/%Y %I:%M:%S %p"))


# Pivot data to wide format
divvy_10_min_wide <- divvy_10_min_clean %>%
  pivot_wider(names_from = ID, values_from = deficit) %>%
  arrange(Timestamp) %>%
  select(-Timestamp)

# Remove column names
colnames(divvy_10_min_wide) <- NULL

# Save csv to StemGNN sub repository
write.csv(divvy_10_min_wide, "/Users/noahanderson/Documents/GitHub/cap-stone-PDAT/src/stem_gnn_model/dataset/divvy_10_min_wide.csv",
          row.names = FALSE, col.names = FALSE)


# Select only hourly updates
divvy_hour_clean <- divvy_10_min_clean %>% 
  group_by(ID, hour = lubridate::hour(Timestamp)) %>%
  filter(Timestamp == min(Timestamp)) %>%
  ungroup() %>%
  select(-hour)

# Create hourly wide data set
divvy_hour_wide <- divvy_hour_clean %>%
  pivot_wider(names_from = ID, values_from = deficit) %>%
  select(-Timestamp)

# Remove column names
colnames(divvy_hour_wide) <- NULL

# Save csv to StemGNN sub repository
write.csv(divvy_hour_wide, "/Users/noahanderson/Documents/GitHub/cap-stone-PDAT/src/stem_gnn_model/dataset/divvy_hour_wide.csv",
          row.names = FALSE, col.names = FALSE)




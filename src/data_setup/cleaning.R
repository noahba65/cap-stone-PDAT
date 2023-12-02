
chicago_ca_clean <- chicago_ca_raw %>%
  st_transform(4269)  

divvy_stations_clean <- divvy_stations_raw %>%
  st_as_sf(coords = c("longitude", "latitude"), crs = 4269)

# Join data frames to identity stations in target community areas
divvy_stations_in_ca <- st_join(chicago_ca_clean %>% filter(pri_neigh %in% target_ca), divvy_stations_clean) 

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
save_csv(divvy_10_min_wide, "/Users/noahanderson/Documents/GitHub/cap-stone-PDAT/src/stem_gnn_model/dataset/divvy_10_min_wide.csv")





# Clean divvy data 
divvy_10_min_clean_percent <- divvy_raw %>%
  rename( percent_full = `Percent Full` ) %>%
  filter( ID %in% id_filter) %>%
  select(Timestamp, ID, percent_full) %>%
  mutate(Timestamp = as.POSIXct(Timestamp, format = "%m/%d/%Y %I:%M:%S %p"))


# Pivot data to wide format
divvy_10_min_wide_percent <- divvy_10_min_clean_percent %>%
  pivot_wider(names_from = ID, values_from = percent_full) %>%
  arrange(Timestamp) %>%
  select(-Timestamp)

# Remove column names
colnames(divvy_10_min_wide_percent) <- NULL

# Save csv to StemGNN sub repository
save_csv(divvy_10_min_wide_percent, "/Users/noahanderson/Documents/GitHub/cap-stone-PDAT/src/stem_gnn_model/dataset/divvy_10_min_wide_percent.csv")





# Join data frames to identity stations in target community areas
divvy_stations_in_ca_small <- st_join(chicago_ca_clean %>% filter(pri_neigh %in% target_ca_small), divvy_stations_clean) 

id_filter_small <- divvy_stations_in_ca_small$id


# Clean divvy data 
divvy_10_min_clean_percent_small <- divvy_raw %>%
  rename( percent_full = `Percent Full` ) %>%
  filter( ID %in% id_filter_small) %>%
  select(Timestamp, ID, percent_full) %>%
  mutate(Timestamp = as.POSIXct(Timestamp, format = "%m/%d/%Y %I:%M:%S %p"))


# Pivot data to wide format
divvy_10_min_wide_percent_small <- divvy_10_min_clean_percent_small %>%
  pivot_wider(names_from = ID, values_from = percent_full) %>%
  arrange(Timestamp) %>%
  select(-Timestamp)

# Remove column names
colnames(divvy_10_min_wide_percent_small) <- NULL

# Save csv to StemGNN sub repository
save_csv(divvy_10_min_wide_percent_small, "/Users/noahanderson/Documents/GitHub/cap-stone-PDAT/src/stem_gnn_model/dataset/divvy_10_min_wide_percent_small.csv")



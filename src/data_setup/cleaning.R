# Clean divvy data 
divvy_10_min_clean <- divvy_time_raw %>% 
  mutate(deficit = as.numeric(available_docks) - as.numeric(docks_in_service)) %>%
  select(timestamp, id, deficit) %>%
  distinct(timestamp, id, .keep_all = TRUE)

# Pivot data to wide format
divvy_10_min_wide <- divvy_10_min_clean %>%
  pivot_wider(names_from = id, values_from = deficit) %>%
  select(-timestamp)

# Remove column names
colnames(divvy_10_min_wide) <- NULL

# Save csv to StemGNN sub repository
write.csv(divvy_10_min_wide, "/Users/noahanderson/Documents/GitHub/cap-stone-PDAT/src/stem_gnn_model/dataset/divvy_10_min_wide.csv",
          row.names = FALSE, col.names = FALSE)


# Select only hourly updates
divvy_hour_clean <- divvy_10_min_clean %>% 
  group_by(id, hour = lubridate::hour(timestamp)) %>%
  filter(timestamp == min(timestamp)) %>%
  ungroup() %>%
  select(-hour)

# Create hourly wide data set
divvy_hour_wide <- divvy_hour_clean %>%
  pivot_wider(names_from = id, values_from = deficit) %>%
  select(-timestamp)

# Remove column names
colnames(divvy_hour_wide) <- NULL

# Save csv to StemGNN sub repository
write.csv(divvy_hour_wide, "/Users/noahanderson/Documents/GitHub/cap-stone-PDAT/src/stem_gnn_model/dataset/divvy_hour_wide.csv",
          row.names = FALSE, col.names = FALSE)




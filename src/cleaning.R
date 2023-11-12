# Clean divvy data 
divvy_time_clean <- divvy_time_raw %>% 
  mutate(deficit = as.numeric(available_docks) - as.numeric(docks_in_service)) %>%
  select(timestamp, id, deficit) %>%
  distinct(timestamp, id, .keep_all = TRUE)

# Pivot data to wide format
divvy_time_wide <- divvy_time_clean %>%
  pivot_wider(names_from = id, values_from = deficit) %>%
  select(-timestamp)

# Remove column names
colnames(divvy_time_wide) <- NULL

# Save csv to StemGNN sub repository
write.csv(divvy_time_wide, "/Users/noahanderson/Documents/GitHub/cap-stone-PDAT/src/StemGNN/dataset/divvy_time_wide.csv",
          row.names = FALSE, col.names = FALSE)

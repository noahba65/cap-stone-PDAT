# Data cleaning for Figures 1 and 2
divvy_stations_in_ca <- st_join(target_area, divvy_stations_clean)
id_filter <- divvy_stations_in_ca$id


# Clean divvy data to give only ID's in target area
divvy_data_ID <- divvy_raw %>%
  filter( ID %in% id_filter) %>%
  select(ID)
target_stations <- divvy_stations_clean %>%
  filter(id %in% divvy_data_ID$ID)
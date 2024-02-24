

chicago_ca_clean <- chicago_ca_raw %>%
  st_transform(4269)  

divvy_stations_clean <- divvy_stations_raw %>%
  st_as_sf(coords = c("longitude", "latitude"), crs = 4269)

# Join data frames to identity stations in target community areas
target_area <- chicago_ca_clean %>% filter(community %in% target_ca)

divvy_stations_in_ca <- st_join(target_area, divvy_stations_clean)

id_filter <- divvy_stations_in_ca$id

target_stations <- divvy_stations_clean %>%
  filter(id %in% id_filter)

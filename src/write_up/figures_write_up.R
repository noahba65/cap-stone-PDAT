# Data cleaning for Figures 1 and 2
divvy_stations_in_ca <- st_join(target_area, divvy_stations_clean)
id_filter <- divvy_stations_in_ca$id


# Clean divvy data to give only ID's in target area
divvy_data_ID <- divvy_raw %>%
  filter( ID %in% id_filter) %>%
  select(ID)
target_stations <- divvy_stations_clean %>%
  filter(id %in% divvy_data_ID$ID)


# Generate figure 1
ggplot() +
  geom_sf(data = chicago_ca_clean) +
  geom_sf(data = target_area, fill = "red") +
  ggtitle("Target Community Areas") +
  theme(
    panel.grid.major = element_blank(), # Remove major grid lines
    panel.grid.minor = element_blank(), # Remove minor grid lines
    axis.text.x = element_blank(), # Remove x-axis labels
    axis.text.y = element_blank(), # Remove y-axis labels
    axis.ticks = element_blank(), # Remove axis ticks
    panel.background = element_rect(fill = "white"), # Set background to white
    plot.title = element_text(face = "bold", size = 20) # Bold and larger title
  )
# Generate Figure 2
ggplot() +
  geom_sf(data = st_union(target_area )) +
  geom_sf(data = target_stations) +
  ggtitle("Target Stations") +
  theme(
    panel.grid.major = element_blank(), # Remove major grid lines
    panel.grid.minor = element_blank(), # Remove minor grid lines
    axis.text.x = element_blank(), # Remove x-axis labels
    axis.text.y = element_blank(), # Remove y-axis labels
    axis.ticks = element_blank(), # Remove axis ticks
    panel.background = element_rect(fill = "white"), # Set background to white
    plot.title = element_text(face = "bold", size = 20) # Bold and larger title
  )
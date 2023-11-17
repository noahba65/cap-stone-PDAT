chicago_ca <- st_read("/Users/noahanderson/Documents/Data/Boundaries-Neighborhoods.geojson") %>%
  st_transform(4269) %>%
  filter(pri_neigh %in% target_ca) 

divvy_stations_url <- "https://data.cityofchicago.org/resource/bk89-9dk7.json"
divvy_stations <- read.socrata(divvy_stations_url) %>%
  st_as_sf(coords = c("longitude", "latitude"), crs = 4269)

# Join data frames to identity stations in target community areas
divvy_stations_in_ca <- st_join(chicago_ca, divvy_stations) 

# Define string for target station ID's
ca_ids_string <- paste(divvy_stations_in_ca$id, collapse = ",")

# Define the base URL for historical divvy time snapshots
divvy_time_base_url <- "https://data.cityofchicago.org/resource/eq45-8inv.json"

# Define the select, where, limit, and order parameters
select_columns <- "$select=id,timestamp,docks_in_service,available_docks"
id_filter <- paste0("id in (", ca_ids_string, ")")
date_filter <- paste0("timestamp >= '", start_date, "' AND timestamp <= '", end_date, "'")
combined_filter <- paste0("$where=", id_filter, " AND ", date_filter)
order_parameter <- "$order=timestamp DESC"

# Combine the base URL with the select, where, limit, and order parameters
divvy_time_url <- paste0(divvy_time_base_url, "?", select_columns, "&", combined_filter, "&", order_parameter)

# Read divvy data
divvy_time_raw <- read.socrata(divvy_time_url)

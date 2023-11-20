chicago_ca_raw <- st_read("/Users/noahanderson/Documents/Data/Boundaries-Neighborhoods.geojson") %>%
  st_transform(4269) %>%
  filter(pri_neigh %in% target_ca) 

divvy_stations_url <- "https://data.cityofchicago.org/resource/bk89-9dk7.json"
divvy_stations_raw <- read.socrata(divvy_stations_url) %>%
  st_as_sf(coords = c("longitude", "latitude"), crs = 4269)


divvy_raw <- read_csv("/Users/noahanderson/Documents/Data/Divvy_Bicycle_Stations_-_Historical.csv")

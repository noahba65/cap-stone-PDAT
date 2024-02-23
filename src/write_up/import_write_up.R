# Read in a local geojson file containing the shapes of Chicago Neighborhoods
chicago_ca_raw <- st_read(chicago_ca_path)


# Read in Divvy names and locations data set
divvy_stations_url <- "https://data.cityofchicago.org/resource/bk89-9dk7.json"
divvy_stations_raw <- read.socrata(divvy_stations_url)


abs_error_h3 <- read_csv(abs_error_file_path_h3, col_names = FALSE)
actual_h3 <- read_csv(actual_file_path_h3, col_names = FALSE)
abs_error_h6 <- read_csv(abs_error_file_path_h6, col_names = FALSE)
actual_h6 <- read_csv(actual_file_path_h6, col_names = FALSE)
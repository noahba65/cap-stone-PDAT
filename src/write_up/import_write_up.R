# Read in a local geojson file containing the shapes of Chicago Neighborhoods
chicago_ca_raw <- st_read(chicago_ca_path)


abs_error_h3 <- read_csv(abs_error_file_path_h3, col_names = FALSE)
actual_h3 <- read_csv(actual_file_path_h3, col_names = FALSE)
abs_error_h6 <- read_csv(abs_error_file_path_h6, col_names = FALSE)
actual_h6 <- read_csv(actual_file_path_h6, col_names = FALSE)

divvy_stations_raw <- read.socrata(divvy_stations_url)

divvy_historical <- read_csv("~/Documents/GitHub/stemGNN_divvy/src/stem_gnn_model/dataset/divvy_10_min_wide_percent.csv")

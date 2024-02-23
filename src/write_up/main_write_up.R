library(tidyverse)
library(kableExtra)
library(RSocrata)
library(sf)

# Read in custom functions
source("src/write_up/functions_write_up.R")

base_dir <- "~/Documents/GitHub/stemGNN_divvy/"
# Results file paths for each horizon
dir_h3 <- "src/stem_gnn_model/output/divvy_10_min_wide_percent/test/test_horizon_3_window_size_6_lr_1.0e-03/"
dir_h6 <- "src/stem_gnn_model/output/divvy_10_min_wide_percent/test/test_horizon_6_window_size_6_lr_1.0e-03/"

# Local path to Chicago Community Areas shape file
chicago_ca_path <- paste0(base_dir, "Data/Boundaries-Neighborhoods.geojson")

# Divvy URL for RSocrata
divvy_stations_url <- "https://data.cityofchicago.org/resource/bbyy-e7gq.json"

# Results file names
abs_error_file_name <- "predict_abs_error.csv"
actual_file_name <- "target.csv"
  
# Construct results file paths
abs_error_file_path_h3 <- paste0(base_dir, dir_h3, abs_error_file_name)
actual_file_path_h3 <- paste0(base_dir, dir_h3, actual_file_name)
abs_error_file_path_h6 <- paste0(base_dir, dir_h6, abs_error_file_name)
actual_file_path_h6 <- paste0(base_dir, dir_h6, actual_file_name)

target_ca <- c("Uptown", "North Center", "Lincoln Square")

message("Importing data.")
source("src/write_up/import_write_up.R")

message("Cleaning data.")
source("src/write_up/cleaning_write_up.R")

message("Generating metrics table.")
source("src/write_up/metrics_write_up.R")


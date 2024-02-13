library(tidyverse)
library(stringr)


source("src/eval/functions_eval.R")

base_dir_h3 <- "~/Documents/GitHub/stemGNN_divvy/src/stem_gnn_model/output/divvy_10_min_wide_percent/test/test_horizon_3_window_size_6_lr_1.0e-03/"
base_dir_h6 <- "~/Documents/GitHub/stemGNN_divvy/src/stem_gnn_model/output/divvy_10_min_wide_percent/test/test_horizon_6_window_size_6_lr_1.0e-03/"

abs_error_file_name <- "predict_abs_error.csv"
actual_file_name <- "target.csv"
  
abs_error_file_path_h3 <- paste0(base_dir_h3, abs_error_file_name)
actual_file_path_h3 <- paste0(base_dir_h3, actual_file_name)
abs_error_file_path_h6 <- paste0(base_dir_h6, abs_error_file_name)
actual_file_path_h6 <- paste0(base_dir_h6, actual_file_name)

abs_error_h3 <- read_csv(abs_error_file_path_h3, col_names = FALSE)
actual_h3 <- read_csv(actual_file_path_h3, col_names = FALSE)
abs_error_h6 <- read_csv(abs_error_file_path_h6, col_names = FALSE)
actual_h6 <- read_csv(actual_file_path_h6, col_names = FALSE)

source("src/eval/metrics_eval.R")


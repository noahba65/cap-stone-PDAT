library(tidyverse)
library(stringr)
library(here)

source("src/eval/functions.R")

set_here()
# Set base directory
base_dir <- "src/stem_gnn_model/output/divvy_10_min_wide/logs"

# Recursively list all log files
log_files <- list.files(base_dir, pattern = "\\.txt$", full.names = TRUE, recursive = TRUE)

# Apply function to all files and combine results
metrics_df <- bind_rows(lapply(log_files, parse_log_file))

write_csv(metrics_df, "src/eval/metrics/metrics_df.csv")


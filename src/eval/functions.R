read_error_and_target_files <- function(base_dir) {
  # List all subdirectories within the base directory
  subdirs <- list.dirs(base_dir, full.names = TRUE, recursive = FALSE)
  
  # Initialize a list to store the data frames
  data_list <- list()
  
  # Loop through each subdirectory
  for (dir in subdirs) {
    # Construct file paths
    error_file_path <- file.path(dir, "predict_abs_error.csv")
    target_file_path <- file.path(dir, "target.csv")
    
    # Check if the files exist and read them
    if (file.exists(error_file_path) && file.exists(target_file_path)) {
      error_df <- read_csv(error_file_path, col_names = FALSE)
      target_df <- read_csv(target_file_path, col_names = FALSE)
      
      # Add the data frames to the list
      data_list[[basename(dir)]] <- list(Error = error_df, Target = target_df)
    }
  }
  
  return(data_list)
}

# Function to calculate RMSE and normalized RMSE
calculate_rmse <- function(data_list, dir_name) {
  error_df <- data_list$Error
  target_df <- data_list$Target
  
  # Calculate RMSE
  rmse <- sqrt(mean(as.matrix(error_df^2)))
  
  # Calculate the standard deviation of the target values
  std_dev <- sd(as.vector(as.matrix(target_df)))
  
  # Normalize RMSE by the standard deviation
  normalized_rmse <- rmse / std_dev
  
  return(data.frame(Directory = dir_name, RMSE = rmse, NormalizedRMSE = normalized_rmse))
}

# Function to extract window size and horizon from directory name
extract_info <- function(dir_name) {
  window_size <- as.numeric(str_extract(dir_name, "(?<=window_size_)[0-9]+"))
  horizon <- as.numeric(str_extract(dir_name, "(?<=horizon_)[0-9]+"))
  return(c(WindowSize = window_size, Horizon = horizon))
}

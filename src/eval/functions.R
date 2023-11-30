read_abs_error_files <- function(base_dir) {
  # List all subdirectories within the base directory
  subdirs <- list.dirs(base_dir, full.names = TRUE, recursive = FALSE)
  
  # Initialize a list to store the data frames
  abs_error_list <- list()
  
  # Loop through each subdirectory
  for (dir in subdirs) {
    # Construct the file path
    file_path <- file.path(dir, "predict_abs_error.csv")
    
    # Check if the file exists
    if (file.exists(file_path)) {
      # Read the CSV file and add it to the list
      abs_error_list[[dir]] <- read_csv(file_path, col_names = FALSE)
    }
  }
  
  return(abs_error_list)
}


# Function to calculate RMSE
calculate_rmse <- function(error_df, dir_name) {
  rmse <- sqrt(mean(as.matrix(error_df^2)))
  return(data.frame(Directory = dir_name, RMSE = rmse))
}

# Function to extract window size and learning rate from directory name
extract_info <- function(dir_name) {
  window_size <- as.numeric(str_extract(dir_name, "(?<=window_size_)[0-9]+"))
  learning_rate <- as.numeric(str_extract(dir_name, "(?<=lr_)[0-9\\.e-]+"))
  return(c(WindowSize = window_size, LearningRate = learning_rate))
}

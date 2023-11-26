# Function to parse a single log file
parse_log_file <- function(file_path) {
  log_content <- read_lines(file_path)
  
  # Extract the Python command line call
  python_command <- log_content[1]
  
  # Extract Horizon and LearningRate using regular expressions
  horizon <- str_extract(python_command, "--horizon \\d+")
  learning_rate <- str_extract(python_command, "--lr [0-9e.-]+")
  
  # Remove the parameter names to get only the values
  horizon <- str_replace(horizon, "--horizon ", "")
  learning_rate <- str_replace(learning_rate, "--lr ", "")
  
  # Extract the final test set metrics using a precise regular expression
  test_metrics_line <- str_subset(log_content, "Performance on test set:")
  test_metrics <- str_match(test_metrics_line, "MAPE: +([0-9.]+) \\| MAE: +([0-9.]+) \\| RMSE: +([0-9.]+)")[, -1]
  
  # Check if test metrics were found and convert them to numeric
  if (length(test_metrics) == 3) {
    mape <- as.numeric(test_metrics[1])
    mae <- as.numeric(test_metrics[2])
    rmse <- as.numeric(test_metrics[3])
  } else {
    mape <- NA
    mae <- NA
    rmse <- NA
  }
  
  # Extract window size from file name
  window_size <- str_extract(basename(file_path), "\\d+")
  
  # Return a data frame row
  data.frame(
    Horizon = horizon,
    LearningRate = learning_rate,
    WindowSize = as.numeric(window_size),
    MAPE = mape,
    MAE = mae,
    RMSE = rmse
  ) %>%
    arrange(Horizon, LearningRate, WindowSize)
}
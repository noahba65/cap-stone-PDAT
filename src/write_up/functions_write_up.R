mase_per_node <- function(abs_error, actual, horizon) {
  # Ensure inputs are numeric matrices
  abs_errors <- as.matrix(abs_error)
  actual_values <- as.matrix(actual)
  
  # Calculate MAE of forecast for each node
  mae_forecast <- apply(abs_errors, 2, mean, na.rm = TRUE)
  
  # Calculate MAE of naive forecast for each node
  mae_naive <- apply(actual_values, 2, function(x) mean(abs(diff(x, lag = horizon)), na.rm = TRUE))
  
  # Calculate MASE for each node
  mase_values <- mae_forecast / mae_naive
  
  return(mase_values)
}

rmse_per_node <- function(abs_error) {
  # Ensure abs_error is a numeric matrix
  abs_error <- as.matrix(abs_error)
  
  # Calculate RMSE for each node by taking the square root of the mean of the squared errors
  rmse_per_node <- apply(abs_error^2, 2, function(x) sqrt(mean(x, na.rm = TRUE)))
  
  return(rmse_per_node)
}


mase_h3 <- mean_mase_per_node(abs_error_h3, actual_h3, horizon = 3)
print(mase_h3)

mase_h6 <- mean_mase_per_node(abs_error_h6, actual_h6, horizon = 6)
print(mase_h6)

rmse_h3 <- mean_rmse_per_node(abs_error_h3)
print(rmse_h3)

rmse_h6 <- mean_rmse_per_node(abs_error_h6)
print(rmse_h6)
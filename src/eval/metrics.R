
# Usage
abs_error_data_horizon_3 <- read_abs_error_files(base_dir_horizon_3)

# Apply the RMSE calculation to each dataframe and combine the results into a dataframe
rmse_results_df_horizon_3 <- map_df(names(abs_error_data_horizon_3), ~calculate_rmse(abs_error_data_horizon_3[[.x]], .x))

# Add columns for window size and learning rate
rmse_results_df_clean_horizon_3 <- rmse_results_df_horizon_3 %>%
  mutate(WindowSize = map_dbl(Directory, ~extract_info(.x)["WindowSize"]),
         LearningRate = map_dbl(Directory, ~extract_info(.x)["LearningRate"]),
         Horizon = 3) %>%
  select(-Directory )


# Usage
abs_error_data_horizon_6 <- read_abs_error_files(base_dir_horizon_6)

# Apply the RMSE calculation to each dataframe and combine the results into a dataframe
rmse_results_df_horizon_6 <- map_df(names(abs_error_data_horizon_6), ~calculate_rmse(abs_error_data_horizon_6[[.x]], .x))

# Add columns for window size and learning rate
rmse_results_df_clean_horizon_6 <- rmse_results_df_horizon_6 %>%
  mutate(WindowSize = map_dbl(Directory, ~extract_info(.x)["WindowSize"]),
         LearningRate = map_dbl(Directory, ~extract_info(.x)["LearningRate"]),
         Horizon = 6) %>%
  select(-Directory )


metrics_df <- rbind(rmse_results_df_clean_horizon_3, rmse_results_df_clean_horizon_6) %>%
  select(Horizon, LearningRate, WindowSize, RMSE) %>%
  arrange(Horizon, LearningRate, WindowSize)

write_csv(metrics_df, "/Users/noahanderson/Documents/GitHub/cap-stone-PDAT/src/eval/metrics/metrics_df.csv")

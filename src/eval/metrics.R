
# Usage
abs_error_and_target_data <- read_error_and_target_files(base_dir)

# Apply the RMSE calculation to each dataframe and combine the results into a dataframe
# rmse_results_df <- map_df(names(abs_error_and_target_data), ~calculate_rmse(abs_error_and_target_data[[.x]], .x))
rmse_results_df <- map_df(names(abs_error_and_target_data), ~calculate_rmse(abs_error_and_target_data[[.x]], .x))


# Add columns for window size and learning rate
rmse_results_df_clean <- rmse_results_df %>%
  mutate(WindowSize = map_dbl(Directory, ~extract_info(.x)["WindowSize"]),
         Horizon = map_dbl(Directory, ~extract_info(.x)["Horizon"]),
         LearningRate = map_dbl(Directory, ~extract_info(.x)["LearningRate"])) %>%
  select(-Directory)


metrics_df <- rmse_results_df_clean %>%
  select(Horizon, LearningRate, WindowSize, RMSE, NormalizedRMSE) %>%
  arrange(Horizon, WindowSize)

write_csv(metrics_df, "/Users/noahanderson/Documents/GitHub/cap-stone-PDAT/src/eval/data/percent_metrics_df.csv")

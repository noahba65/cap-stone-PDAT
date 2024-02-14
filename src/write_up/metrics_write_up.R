
mase_h3 <- mean_mase_per_node(abs_error_h3, actual_h3, horizon = 3)
mase_h3_round <- round(mase_h3, 2)

mase_h6 <- mean_mase_per_node(abs_error_h6, actual_h6, horizon = 6)
mase_h6_round <- round(mase_h6, 2)

rmse_h3 <- mean_rmse_per_node(abs_error_h3)
rmse_h3_string <- paste0(round(rmse_h3, 1) , "%")

rmse_h6 <- mean_rmse_per_node(abs_error_h6)
rmse_h6_string <- paste0(round(rmse_h6, 1) , "%")


metrics_df <- data.frame(Metric = c("RMSE", "RMSE", "MASE", "MASE"),
           Horizon = c(3, 6, 3, 6),
           Value = c(rmse_h3_string, rmse_h6_string, mase_h3_round, mase_h6_round))

kable(metrics_df)


# Adjust column widths and table width
kable_styled <- kable(metrics_df, "html", align = c('l', 'c', 'r'), 
                      col.names = c("Metric", "Horizon", "Value")) %>%
  kable_styling(bootstrap_options = c("striped", "hover"), 
                full_width = TRUE, 
                position = "center", full_width = F) %>%
  column_spec(1, width = ".2in") %>%  # Adjust the width of the first column
  column_spec(2, width = ".5in") %>%  # Adjust the width of the second column
  column_spec(3, width = ".5in")      # Adjust the width of the third column

# Save the table as a PDF with better spacing
save_kable(kable_styled, "metrics_table.pdf")
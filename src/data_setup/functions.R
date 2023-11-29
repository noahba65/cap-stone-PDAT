# Function to save CSV with override option
save_csv <- function(data, file_path, OVERRIDE = FALSE) {
  if (file.exists(file_path)) {
    if (OVERRIDE) {
      # Overwrite the existing file
      write.csv(data, file_path, row.names = FALSE, col.names = FALSE)
      message("File overwritten at: ", file_path)
    } else {
      # File exists and OVERRIDE is FALSE, present a warning
      warning("File already exists. Set OVERRIDE = TRUE to overwrite.")
    }
  } else {
    # File does not exist, write the file
    write_csv(data, file_path, row.names = FALSE, col.names = FALSE)
    message("File saved at: ", file_path)
  }
}

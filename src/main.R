
library(RSocrata)
library(tidyverse)
library(sf)


# Define parameters for date range
start_date <- "2022-06-01"
end_date <- "2022-09-01" 

# Define vector for community areas to be queried
target_ca <- c( "Uptown", "North Center", "Lincoln Square")

message("Importing data.")
source("src/import.R")

message("Cleaning data.")
source("src/cleaning.R")




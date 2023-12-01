
library(RSocrata)
library(tidyverse)
library(sf)

options(scipen = 999)

# Define vector for community areas to be queried
target_ca <- c( "Uptown", "North Center", "Lincoln Square")


message("Importing data.")
source("/Users/noahanderson/Documents/GitHub/cap-stone-PDAT/src/data_setup/import.R")

message("Cleaning data.")
source("/Users/noahanderson/Documents/GitHub/cap-stone-PDAT/src/data_setup/cleaning.R")




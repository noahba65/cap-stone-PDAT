
library(RSocrata)
library(tidycensus)
library(tidyverse)
library(sf)
library(riem)
library(lwgeom)


# Define parameters
start_date <- "2019-01-01"
end_date <- "2020-01-01"

message("Importing data.")
source("src/import.R")

message("Cleaning data.")
source("src/cleaning.R")

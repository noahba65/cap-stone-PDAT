
library(RSocrata)
library(tidycensus)
library(tidyverse)
library(sf)
library(riem)


# Define parameters
start_date <- "2019-01-01"
end_date <- "2020-01-01"


source("src/import.R")
source("src/cleaning.R")

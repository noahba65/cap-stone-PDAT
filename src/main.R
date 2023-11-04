
library(RSocrata)
library(tidycensus)
library(tidyverse)
library(sf)
library(riem)
library(lwgeom)
library(reticulate)


# Define parameters
start_date <- "2019-01-01"
end_date <- "2020-01-01"

message("Importing data.")
source("src/import.R")

message("Cleaning data.")
source("src/cleaning.R")

# Set the path to the virtual environment you've created
# The path should be to the directory containing the 'bin' folder
# of the virtual environment (replace 'path_to_venv' with your actual path)
use_virtualenv("/Users/noahanderson/Documents/GitHub/cap-stone-PDAT/.venv", required = TRUE)


# Source the Python script
source_python("src/model.py")



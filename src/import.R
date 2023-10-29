# Base URL for fetching Divvy bike share data from the City of Chicago's database
divvy_url <- "https://data.cityofchicago.org/resource/fg6s-gzvg.json?"

# Construct the full URL for data retrieval
# Checks if 'limit' is null, and constructs the URL accordingly
divvy_url_full <- ifelse( is.null(limit),
                          # Construct URL without limit parameter
                          paste0(divvy_url,"$where=start_time >= '", start_date, 
                                 "' AND start_time < '", end_date, 
                                 "'&$order=", order_by),
                          # Construct URL with limit parameter
                          paste0(divvy_url,"$where=start_time >= '", start_date, 
                                 "' AND start_time < '", end_date, 
                                 "'&$order=", order_by, 
                                 "&$limit=", limit)
)

# Fetch Divvy data using the constructed URL and store in a dataframe
divvy_df <- read.socrata(divvy_url_full)

# Base URL for fetching rail stops data from the City of Chicago's database
rail_stops_url <- "https://data.cityofchicago.org/resource/8pix-ypme.json"

# Fetch rail stops data using the provided URL
rail_stops <- read.socrata(rail_stops_url)

# Retrieve Cook County's 2010 decennial population data at the tract level
# Using the 'tidycensus' package
cook_population <- get_decennial(geography = "tract", 
                                 variables = "P001001", 
                                 year = 2010, 
                                 state = "IL", 
                                 county = "Cook County", 
                                 geometry = TRUE)

# Retrieve weather data for ORD station between given start and end dates
# Filters specific columns (valid, tmpf, p01i, sknt) from the fetched data
weather.Data <- 
  riem_measures(station = "ORD", date_start = start_date, date_end = end_date) %>%
  select(valid, tmpf, p01i, sknt)

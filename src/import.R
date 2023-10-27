
# Construct URL
divvy_url <- paste0(base_url,
                    "$where=start_time >= '", start_date, 
                    "' AND start_time < '", end_date, 
                    "'&$order=", order_by, 
                    "&$limit=", limit)

divvy_df <- read.socrata(divvy_url)



rail_stops_url <- "https://data.cityofchicago.org/resource/8pix-ypme.json"

rail_stops <- read.socrata(rail_stops_url)

cook_population <- get_decennial(geography = "tract", 
                                 variables = "P001001", 
                                 year = 2010, 
                                 state = "IL", 
                                 county = "Cook County", 
                                 geometry = TRUE)

weather.Data <- 
  riem_measures(station = "ORD", date_start = as.character(min(daily_trips$date)), date_end = as.character(max(daily_trips$date))) %>%
  select(valid, tmpf, p01i, sknt) 
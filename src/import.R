
# Construct URL
divvy_url_full <- ifelse( is.null(limit),
paste0(divvy_url,"$where=start_time >= '", start_date, 
       "' AND start_time < '", end_date, 
       "'&$order=", order_by),
paste0(divvy_url,"$where=start_time >= '", start_date, 
       "' AND start_time < '", end_date, 
       "'&$order=", order_by, 
       "&$limit=", limit)
)

divvy_df <- read.socrata(divvy_url_full)



rail_stops_url <- "https://data.cityofchicago.org/resource/8pix-ypme.json"

rail_stops <- read.socrata(rail_stops_url)

cook_population <- get_decennial(geography = "tract", 
                                 variables = "P001001", 
                                 year = 2010, 
                                 state = "IL", 
                                 county = "Cook County", 
                                 geometry = TRUE)

weather.Data <- 
  riem_measures(station = "ORD", date_start = start_date, date_end = end_date) %>%
  select(valid, tmpf, p01i, sknt) 
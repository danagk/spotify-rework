# this file creates a regional map, shaded according to music tastes in each
# country of North America

library("dplyr")
library("leaflet")
library("spData")

# read csv data with track info by country
country_data <- read.csv(file = "../data/country_data.csv", stringsAsFactors 
                         = F)

# group data by selected audio characteristic
# in final version of report, this will be interactive
# for now, it's hard-coded to display valence
by_country <- country_data %>%
  group_by(country = playlist_name) %>%
  summarise(valence = mean(valence))

# join this df to shapefile
merged_countries <- merge(by_country, world, by.x = "country", by.y = 
                            "name_long")

# create map shaded according to selected characteristic (valence)
countries_map <- leaflet(world) %>%
  addProviderTiles(providers$CartoDB.Positron) %>%
  setView(-100, 39, zoom = 2) %>%
  addPolygons()

# still to do:
#   edit map styles
#   create palette
#   shade map according to values in by_country
#   check styler and lintr for errors

# this file creates a regional map, shaded according to music tastes in each
# country of North America

library("dplyr")

# read csv data with track info by country
country_data <- read.csv(file = "../data/country_data.csv", stringsAsFactors = F)

# group data by selected audio characteristic
# in final version of report, this will be interactive
# for now, it's hard-coded to display valence
by_country <- country_data %>%
  group_by(country = playlist_name) %>%
  summarise(valence = mean(valence))

# create map shaded according to desired characteristic
# code goes here
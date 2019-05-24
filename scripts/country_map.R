# this file creates a regional map, shaded according to music tastes in each
# country of North America

library("dplyr")
library("plotly")
library("ggplot2")

# read csv data with track info by country
# set to reference data relative to *index.Rmd* location, not this file
country_data <- read.csv(
  file = "./data/country_data.csv", stringsAsFactors
  = F
)

# group data by selected audio characteristic
# in final version of report, this will be interactive
# for now, it's hard-coded to display valence
by_country <- country_data %>%
  group_by(country = playlist_name) %>%
  summarise(valence = mean(valence))

# set country names to match for merge
by_country$country[by_country$country == "United States"] <- "USA"

# join this df to shapefile
country_shape <- map_data("world", region = by_country$country) %>%
  rename(country = region) %>%
  merge(by_country, by = "country")

# create map shaded according to selected characteristic (valence)
country_map <- ggplot(country_shape, aes(text = paste0("country: ", country))) +
  geom_polygon(
    mapping = aes(x = long, y = lat, group = group, fill = valence),
    color = "white",
    size = .1
  ) +
  coord_map(xlim = c(-175, -45), ylim = c(-10, 80))

# make interactive with plotly
country_map <- ggplotly(country_map) %>%
  layout(
    title = "Average Valence in Top 50 Songs",
    xaxis = list(title = ""),
    yaxis = list(title = ""),
    geo = list(
      scope = "north america",
      lonaxis = list(range = c(-175, -45)),
      lataxis = list(range = c(-10, 80))
    )
  )
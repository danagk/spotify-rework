# this file defines a function to create a regional map, shaded according to
# music tastes in each country of North America

#### edit note: the hovertext is formatted incorrectly - I will fix

build_map <- function(df,feature) {
  feature <- rlang::sym(feature) # treat string input as symbol
  
  # group data by selected audio feature
  by_country <- df %>%
    group_by(country = playlist_name) %>%
    summarise(feature = mean(!!feature))
  
  # set country names to match for merge
  by_country$country[by_country$country == "United States"] <- "USA"
  
  # join this df to shapefile
  country_shape <- map_data("world", region = by_country$country) %>%
    rename(country = region) %>%
    merge(by_country, by = "country")
  
  # create map shaded according to selected feature
  country_map <- ggplot(country_shape, aes(text = paste0("country: ", country))) +
    geom_polygon(
      mapping = aes(x = long, y = lat, group = group, fill = feature),
      color = "white",
      size = .1
    ) +
    coord_map(xlim = c(-175, -45), ylim = c(-10, 80))
  
  # make interactive with plotly
  country_map <- ggplotly(country_map) %>%
    layout(
      xaxis = list(title = ""),
      yaxis = list(title = ""),
      title = paste0(feature, " by Country"),
      geo = list(
        scope = "north america",
        lonaxis = list(range = c(-175, -45)),
        lataxis = list(range = c(-10, 80))
      )
    )
  return(country_map)
}
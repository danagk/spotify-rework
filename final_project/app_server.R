# Load libraries so they are available
library(shiny)
library(ggplot2)
library(plotly)
library(reshape2)

# Create a shiny server
server <- function(input, output) {
  # Create and render a bar plot that uses the relevant y inputs (Julia)
  output$bar <- renderPlot({
    genre_bar_chart <- songs_df %>%
      ggplot() +
      # Create bar chart with genre on the y axis and valence on the x axis
      # Order the valence from greatest to least
      geom_bar(aes_string(x = "genre", y = input$y_var_bar),
               stat = "summary", fun.y = "mean", # take the mean of the valence for
               # each genre
               fill = "#00CCCC") +
      # title/axis labels
      ggtitle(paste0("Average ", input$y_var_bar , " per Genre")) +
      xlab("Genre") +
      ylab(paste0("Average ", input$y_var_bar)) +
      theme(axis.text.x = element_text(angle = 60, hjust = 1))
  genre_bar_chart
  })
  # Next Chart
  output$histogram <- renderPlotly({
    #storeWarn<- getOption("warn")
    #options(warn = -1) 
    #https://stackoverflow.com/questions/45499460/selectinput-and-reactive-plotly-bar-chart-in-shiny
    plot_ly(songs_df, x = ~input$feature) %>%
      add_histogram()
    filtered <- songs_df %>%
      select(genre, input$feature)
    histogram_chart <- melt(filtered, id.vars = input$feature) %>%
      plot_ly(alpha = 0.5, colors = "Set2") %>%
      add_histogram(x = ~get(input$feature), type = 'histogram', name = ~value, color = ~value) %>%
      layout(title = "Histogram of Features in each Genre", 
             xaxis = list(title = "Feature"),
             yaxis = list(title = "Count"),
             barmode = "overlay")
    histogram_chart
  })
  # create and render an interactive map of pop music tastes in each country
  output$map <- renderPlotly({
    feature <- rlang::sym(input$map_feature) # treat string input as symbol
    
    # group data by selected audio feature
    by_country <- country_data %>%
      group_by(country = playlist_name) %>%
      summarise(feature = mean(!!feature))
    
    # set country names to match for merge
    by_country$country[by_country$country == "United States"] <- "USA"
    
    # join this df to shapefile
    country_shape <- map_data("world", region = by_country$country) %>%
      rename(country = region) %>%
      merge(by_country, by = "country")
    
    # create map shaded according to selected feature
    country_map <- ggplot(country_shape, aes(text = paste0("country: ", country,
                           "\n",input$map_feature, ": ", feature))) +
      geom_polygon(
        mapping = aes(x = long, y = lat, group = group, fill = feature),
        color = "white",
        size = .1
      ) +
      coord_map(xlim = c(-175, 40), ylim = c(-35, 70)) +
      labs(fill = input$map_feature)
    
    # make interactive with plotly
    country_map <- ggplotly(country_map, tooltip = "text") %>%
      layout(
        xaxis = list(title = ""),
        yaxis = list(title = ""),
        title = paste0("Average", feature, " in Popular Music by Country"),
        margin = list(b = 50, t = 60)
      )
    country_map
  })
}
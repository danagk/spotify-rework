# Load libraries so they are available
library(shiny)
library(ggplot2)
library(plotly)
library(reshape2)

# Load function source file
source("./build_map.R")

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
    return(build_map(country_data,input$map_feature))
  })
}





# Load libraries so they are available
library(shiny)
library(ggplot2)

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
  
  # Next Chart
}


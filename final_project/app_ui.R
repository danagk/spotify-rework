# Load libraries so they are available
library(shiny)
library(ggplot2)
library(dplyr)
library(tidyr)

select_values_bar <- colnames(songs_df[, c(5:10, 12, 13, 15, 16, 18)])
  
# Define content for the first page (Julia)
page_one <- tabPanel(
  "Musical Features Bar Plot", # label for the tab in the navbar
  # show a displayed title
  titlePanel("Musical Features for Each Genre"),
  p("An exploration into the average of various musical features by genre."),
  # This content uses a sidebar layout
  sidebarLayout(
    sidebarPanel( 
      # Create a variable `y_var_bar` that stores a `selectInput()`
      # for your variable to appear on the y axis of your chart.
      y_input <- selectInput(
        inputId = "y_var_bar",
        label = "Y Variable",
        choices = select_values_bar, # available choices
        selected = "popularity" # default value
      )
    ),
    mainPanel( # Main panel with chart
      plotOutput("bar")
    )
  )
)

# Pass each page to a multi-page layout (`navbarPage`)
ui <- navbarPage(
  "Musical Genre Exploration", # application title
  page_one         # include the first page content
)

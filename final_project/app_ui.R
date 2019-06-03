# Load libraries so they are available
library(shiny)
library(ggplot2)
library(dplyr)
library(tidyr)
library(plotly)

select_values_bar <- colnames(songs_df[, c(5:10, 12, 13, 15, 16, 18)])
select_bar_country <- colnames(country_data[,c(6:7,12:16)])
  
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

page_two <- tabPanel(
  "Musical Features Histogram", # label for the tab in the navbar
  # show a displayed title
  titlePanel("??"),
  p("An exploration .."),
  # This content uses a sidebar layout
  sidebarLayout(
    sidebarPanel( 
      # Create a variable `features` that stores a `selectInput()`
      # for your variable to appear on the y axis of your chart.
      selectInput(
        inputId = "feature",
        label = "feature",
        choices = select_values_bar # available choices
      )
    ),
    mainPanel( # Main panel with chart
      plotlyOutput("histogram")
    )
  )
)

page_three <- tabPanel(
  "Musical Features Map", # label for the tab in the navbar
  titlePanel("Features Map"),
  sidebarLayout(
    sidebarPanel(
      selectInput( # select musical feature to map
        "map_feature",
        label = "Musical Feature to Map",
        choices = select_bar_country
      )
    ),
    mainPanel( # output map in main panel
      plotlyOutput("map")
    )
  )
)

# Pass each page to a multi-page layout (`navbarPage`)
ui <- navbarPage(
  "Musical Genre Exploration", # application title
  page_one,         # include the first page content
  page_two,
  page_three
)

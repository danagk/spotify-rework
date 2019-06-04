# Load libraries so they are available
library(shiny)
library(ggplot2)
library(dplyr)
library(tidyr)
library(plotly)

select_values_bar <- colnames(songs_df[, c(5:10, 12, 13, 15, 16, 18)])
select_bar_country <- colnames(country_data[,c(6:7,12:16)])

# Create overview page content
overview <- fluidPage(
  h1(strong("A Spotify Exploration")),
  p("The purpose of the project is to explore and analyze the trends in music 
    found from Spotify data. The questions that structured our project include,",
    em("how audio features such as valence or danceability vary across genres,
       the popularity across genres, and how audio features of popular music differs
       between different countries"), ". The source of our data comes from",
    a(href = "https://cran.r-project.org/web/packages/spotifyr/spotifyr.pdf",
      "the Spotifyr package in R"), " and ",
    a(href = "https://developer.spotify.com/documentation/web-api/",
      "the Spotify Web API."),
    "Our interactive pages include a Bar Plot, a Histogram, and a Map that display musical features
    by genre or country."),
  # Retrieved from Pinterest 
  img("", src = "https://i.pinimg.com/474x/c7/59/2d/c7592d4968db39641f6a530d17c40d26--streaming-music-musica-streaming.jpg"
  )
    )

# Define overview panel
overview_panel <- tabPanel(
  "Overview",
  overview
)

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
  titlePanel("Comparisons between every genre on each music feature"),
  p("An exploration into range of each music feature for all genre."),
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
  p("An exploration into the average of popular music features by country."),
  sidebarLayout(
    sidebarPanel(
      selectInput( # select musical feature to map
        "map_feature",
        label = "Musical Feature to Map",
        choices = select_bar_country
      )
    ),
    mainPanel( # output map in main panel
      plotlyOutput("map"),
      p("This map displays the average value for the selected feature across
         the top 50 most popular songs for each country, as of May 2019. Each
         country outline is shaded according to that value. Note that data is
         only available for countries in which Spotify is available, so our data
         excludes Venezuela, Suriname, Guyana, and French Guiana.")
    )
  )
)

summary <- fluidPage(
  h1(strong("Summary Takeaways")),
  p("Summary from pages")
    )

summary_panel <- tabPanel(
  "Summary Information",
  summary
)

# Pass each page to a multi-page layout (`navbarPage`)
ui <- navbarPage(
  "Musical Genre Exploration", # application title
  overview_panel,
  page_one,         # include the first page content
  page_two,
  page_three,
  summary_panel
)
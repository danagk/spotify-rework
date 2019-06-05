# Load libraries so they are available
library(shiny)
library(ggplot2)
library(dplyr)
library(tidyr)
library(plotly)

select_values_bar <- colnames(songs_df[, c(5:10, 12, 13, 15, 16, 18)])
select_bar_country <- colnames(country_data[, c(6:7, 12:16)])

# Create overview page content
overview <- fluidPage(
  includeCSS("style.CSS"),
  tags$h2("A Spotify Exploration"),
  tags$p("The purpose of the project is to explore and analyze the
        trends in music found from Spotify data. The questions
        that structured our project include how audio features
        such as valence or danceability vary across genres, the
        popularity across genres, and how audio features of popular music
        differs between different countries. The source of our data comes from
        the Spotifyr package in R and the Spotify Web API. Our interactive web
        pages include a Bar Plot, a Histogram, and a Map that display musical
        features by genre or country. Our interactive pages include a Bar Plot,
        a Histogram, and a Map that display musical features by genre
         or country."),
  tags$h3("Defining our Variables"),
  tags$p("Popularity is defined by the amount of listens on the Spotify music
        charts. Valence and energy can be described as whether the music
        may make someone feel happy and positive or sad and negative."),
  # Retrieved from Pinterest
  img(src = paste0(
    "https://i.pinimg.com/474x/c7/59/2d/",
    "c7592d4968db39641f6a530d17c40d26--streaming-",
    "music-musica-streaming.jpg"))
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
      plotlyOutput("bar")
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
    mainPanel( # output map and description in main panel
      p("This map displays the average value for the selected feature across
         the top 50 most popular songs for each country in the Americas, as of
         May 2019. Each country outline is shaded according to that value. Note
         that data is only available for countries in which Spotify is
         available, so our data excludes Venezuela, Suriname, Guyana, and French
         Guiana."),
      plotlyOutput("map")
    )
  )
)

# Summary content
summary <- fluidPage(
  h2("Summary Takeaways"),
  h1("First Takeaway"),
  p("In the histogram, it can be noted that the graphs between
    different genres overlap quite a bit for each musical feature.
    For popularity, there were 1000 counts for the Classical
    genre with zero popularity, unlike all other genres. The
    broader implications of this piece of data is that most music
    have very similar musical features with the exception of slower
    or quieter genres, such as Classical, which has an impact on
    their popularity in Spotify charts."),
  h1("Second Takeaway"),
  p("In the map, you can see the differences of popular songs
    between North American countries and South American
    countries by the musical features. It is interesting to note
    that South American countries prefer their music to be highly
    positive, while valence and energy gets lower or less positive
    as you go futher North. As seen in the maps below, the darker
    blue correlates to lower valence and energy and the lighter
    blue correlates to higher valence and energy. The broader
    implications of this is that themes in music between different
    cultures are apparent through this distinctive comparison of
    positivity and negativity. This could be an effect of mass
    media's influence on societies of different cultures."),
  HTML('<img src = "https://i.ibb.co/HdFhY20/energy-map.png">'),
  HTML('<img src = "https://i.ibb.co/Qm1FZCD/valence-map.png">'),
  h1("Third Takeaway"),
  p("In the bar plot, averages of different musical features are shown by
    genre. The following table shows the average danceability, energy, valence,
    acousticness, and tempo based on music genre. The table is ordered by
    which genre has the highest average popularity ratings on a scale from
    0-100. Pop music is highest on the charts. Ska music has the fastest
    average tempo. Reggae music has the highest average valence. Ska music
    has the highest average energy. Opera music is the most acoustic on
    average. Reggaeton music has the highest average danceability."),
  p("Interestingly, the table shows trends across genres such as when
    popularity of a genre decreases acousticness tends to increase. For
    example, opera and classical music are two of the least popular genres
    and have average acousticness of 0.95 and 0.87, respectively. In
    addition, reggaeton and reggae are not popular genres yet have the
    highest levels of danceability at 0.73 and 0.7, respectively. The
    broader implications of this insight may be telling of what Spotify
    listeners value in their music tastes and features and what is not
    valued."),
  tableOutput("table")
  )

# Define Summary Panel
summary_panel <- tabPanel(
  "Summary Takeaways",
  summary
)

# Pass each page to a multi-page layout (`navbarPage`)
ui <- navbarPage(theme = "style.CSS",
                 tags$header("Musical Genre Exploration"), # application title
                 overview_panel,
                 page_one,         # include the first page content
                 page_two,
                 page_three,
                 summary_panel
)
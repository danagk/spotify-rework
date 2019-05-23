# Set up and source
library("spotifyr")
library("tidyverse")
library("knitr")
library("dplyr")
source("api_keys.R")
source("summary_data_frame.R")

# Summary info
get_summary_info <- function(dataframe) {
  songs <- list()
  # What is the name of the most popular song?
  songs$most_popular_song <- songs_dataframe %>%
    filter(popularity == max(popularity)) %>%
    pull(name)
  
  # What year had the most popular ratings on average?
  songs$year_most_popular <- songs_dataframe %>%
    group_by(release_year) %>%
    summarize(popularity = mean(popularity)) %>%
    arrange(-popularity) %>%
    head(1) %>%
    pull(release_year)
  
  # Which genre has the most songs with explicit lyrics?
  songs$most_explicit_genre <- songs_dataframe %>%
    group_by(genre) %>%
    filter(explicit == "TRUE") %>%
    count() %>%
    arrange(-n) %>%
    head(1) %>%
    pull(genre)
  
  return (songs)
}
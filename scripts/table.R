# Set up and source
library(tidyverse)
library(dplyr)
# How does popularity measure to different qualities of a song?
get_table_info <- function(df) {
  songs_table <- songs_df %>%
    group_by(genre) %>%
    summarize(mean_danceability = round(mean(danceability), 2),
              mean_energy = round(mean(energy), 2),
              mean_valence = round(mean(valence), 2),
              mean_acousticness = round(mean(acousticness), 2),
              mean_tempo = round(mean(tempo), 2),
              mean_popularity = round(mean(popularity), 0)) %>%
    arrange(-mean_popularity)
  songs_table <- rename(songs_table, "Genre" = genre)
  songs_table <- rename(songs_table, "Average Danceability" = mean_danceability)
  songs_table <- rename(songs_table, "Average Energy" = mean_energy)
  songs_table <- rename(songs_table, "Average Valence" = mean_valence)
  songs_table <- rename(songs_table, "Average Acousticness" = mean_acousticness)
  songs_table <- rename(songs_table, "Average Tempo" = mean_tempo)
  songs_table <- rename(songs_table, "Popularity Rating" = mean_popularity)
  return(songs_table)
}

dance <- songs_df %>%
  group_by(genre) %>%
  summarize(danceability = round(mean(danceability), 2)) %>%
  arrange(-danceability) %>%
  head(1) %>%
  pull(genre)

popular <- songs_df %>%
  group_by(genre) %>%
  summarize(popularity = round(mean(popularity), 0)) %>%
  arrange(-popularity) %>%
  head(1) %>%
  pull(genre)

tempo <- songs_df %>%
  group_by(genre) %>%
  summarize(tempo = round(mean(tempo), 2)) %>%
  arrange(-tempo) %>%
  head(1) %>%
  pull(genre)

valence <- songs_df %>%
  group_by(genre) %>%
  summarize(valence = round(mean(valence), 2)) %>%
  arrange(-valence) %>%
  head(1) %>%
  pull(genre)

energy <- songs_df %>%
  group_by(genre) %>%
  summarize(energy = round(mean(energy), 2)) %>%
  arrange(-energy) %>%
  head(1) %>%
  pull(genre)

acoustic <- songs_df %>%
  group_by(genre) %>%
  summarize(acousticness = round(mean(acousticness), 2)) %>%
  arrange(-acousticness) %>%
  head(1) %>%
  pull(genre)
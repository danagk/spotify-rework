# Set up and source
library("spotifyr")
library("tidyverse")
library("knitr")
library("dplyr")
source("api_keys.R")

# Authentication
Sys.setenv(SPOTIFY_CLIENT_ID = id_api_key)
Sys.setenv(SPOTIFY_CLIENT_SECRET = secret_api_key)

# Pull Access Token into R
access_token <- get_spotify_access_token()

# Set up song dataframe for summary

# Jazz
jazz_songs <- get_recommendations(limit = 100,
                                  seed_genres = "jazz") %>% 
  mutate(genre = "jazz") %>%
  transform(release_year = substring(album.release_date, 1, 4)) %>%
  select(genre, name, id, popularity, explicit, release_year)

jazz_song_features = get_track_audio_features(jazz_songs$id)
jazz_songs <- merge(jazz_songs, jazz_song_features, by = "id")

# Rock
rock_songs <- get_recommendations(limit = 100,
                                  seed_genres = "rock") %>% 
  mutate(genre = "rock") %>% 
  transform(release_year = substring(album.release_date, 1, 4)) %>%
  select(genre, name, id, popularity, explicit, release_year)

rock_songs_features = get_track_audio_features(rock_songs$id)
rock_songs <- merge(rock_songs, rock_songs_features, by = "id")

#Pop
pop_songs <- get_recommendations(limit = 100,
                                 seed_genres = "pop") %>%
  mutate(genre = "pop") %>%
  transform(release_year = substring(album.release_date, 1, 4)) %>%
  select(genre, name, id, popularity, explicit, release_year)
pop_songs_features <- get_track_audio_features(pop_songs$id)
pop_songs <- merge(pop_songs, pop_songs_features, by = "id")

#Hip Hop
hip_hop_songs <- get_recommendations(limit = 100,
                                     seed_genres = "hip-hop") %>% 
  mutate(genre = "hip-hop") %>% 
  transform(release_year = substring(album.release_date, 1, 4)) %>%
  select(genre, name, id, popularity, explicit, release_year) 
hip_hop_songs_features <- get_track_audio_features(hip_hop_songs$id)
hip_hop_songs <- merge(hip_hop_songs, hip_hop_songs_features, by = "id")

# Country
country_songs <- get_recommendations(limit = 100,
                                     seed_genres = "country") %>%
  mutate(genre = "country") %>%
  transform(release_year = substring(album.release_date, 1, 4)) %>%
  select(genre, name, id, popularity, explicit, release_year)
country_songs_features <- get_track_audio_features(country_songs$id)
country_songs <- merge(country_songs, country_songs_features, by = "id")

# Classical
classical_songs <- get_recommendations(limit = 100,
                                       seed_genres = "classical") %>%
  mutate(genre = "classical") %>%
  transform(release_year = substring(album.release_date, 1, 4)) %>%
  select(genre, name, id, popularity, explicit, release_year) 
classical_songs_features <- get_track_audio_features(classical_songs$id)
classical_songs <- merge(classical_songs, classical_songs_features, by = "id")

# Metal
metal_songs <- get_recommendations(limit = 100,
                                   seed_genres = "metal") %>%
  mutate(genre = "metal") %>%
  transform(release_year = substring(album.release_date, 1, 4)) %>%
  select(genre, name, id, popularity, explicit, release_year)

metal_songs_features <- get_track_audio_features(metal_songs$id)
metal_songs <- merge(metal_songs, metal_songs_features, by = "id")

# Bind data
songs_dataframe <- rbind(jazz_songs, rock_songs, pop_songs, hip_hop_songs,
                         country_songs, classical_songs, metal_songs)
# Set up and source
library("spotifyr")
library("knitr")
library("dplyr")
source("api_keys.R")

# Authentication
Sys.setenv(SPOTIFY_CLIENT_ID = id_api_key)
Sys.setenv(SPOTIFY_CLIENT_SECRET = secret_api_key)

# Pull Access Token into R
access_token <- get_spotify_access_token()

# Set up dataframe for table

# Jazz
jazz_songs_table <- get_recommendations(limit = 100,
                                   seed_genres = "jazz") %>% 
  mutate(genre = "Jazz") %>%
  select(genre, name, id, popularity)

jazz_features = get_track_audio_features(jazz_songs_table$id)
jazz_songs_table <- merge(jazz_songs_table, jazz_features, by = "id")

# Rock
rock_songs_table <- get_recommendations(limit = 100,
                                   seed_genres = "rock") %>% 
  mutate(genre = "Rock") %>% 
  select(genre, name, id, popularity, popularity) 

rock_features = get_track_audio_features(rock_songs_table$id)
rock_songs_table <- merge(rock_songs_table, rock_features, by = "id")

#Pop
pop_songs_table <- get_recommendations(limit = 100,
                                  seed_genres = "pop") %>%
  mutate(genre = "Pop") %>%
  select(genre, name, id, popularity)
pop_features <- get_track_audio_features(pop_songs_table$id)
pop_songs_table <- merge(pop_songs_table, pop_features, by = "id")

#Hip Hop
hip_hop_songs_table <- get_recommendations(limit = 100,
                                      seed_genres = "hip-hop") %>% 
  mutate(genre = "Hip-hop") %>% 
  select(genre, name, id, popularity) 
hip_hop_features <- get_track_audio_features(hip_hop_songs_table$id)
hip_hop_songs_table <- merge(hip_hop_songs_table, hip_hop_features, by = "id")

# Country
country_songs_table <- get_recommendations(limit = 100,
                                      seed_genres = "country") %>%
  mutate(genre = "Country") %>%
  select(genre, name, id, popularity)
country_features <- get_track_audio_features(country_songs_table$id)
country_songs_table <- merge(country_songs_table, country_features, by = "id")

# Classical
classical_songs_table <- get_recommendations(limit = 100,
                                        seed_genres = "classical") %>%
  mutate(genre = "Classical") %>%
  select(genre, name, id, popularity) 
classical_features <- get_track_audio_features(classical_songs_table$id)
classical_songs_table <- merge(classical_songs_table, classical_features, by = "id")

# Metal
metal_songs_table <- get_recommendations(limit = 100,
                                    seed_genres = "metal") %>%
  mutate(genre = "Metal") %>%
  select(genre, name, id, popularity)

metal_features <- get_track_audio_features(metal_songs_table$id)
metal_songs_table<- merge(metal_songs_table, metal_features, by = "id")

# Bind data
songs_df <- rbind(jazz_songs_table, rock_songs_table, pop_songs_table,
                  hip_hop_songs_table, country_songs_table,
                  classical_songs_table, metal_songs_table)
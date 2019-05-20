library("spotifyr")
library("tidyverse")
library("knitr")
library("dplyr")
source(api_key.R)

jazz_songs <- get_recommendations(limit = 100,
                                  seed_genres = "jazz") %>% 
                                  mutate(genre = "jazz") %>% 
                                  select(genre, name, id)
jazz_song_features = get_track_audio_features(jazz_songs$id)
jazz_songs <- merge(jazz_songs, jazz_song_features, by = "id")

rock_songs <- get_recommendations(limit = 100,
                                  seed_genres = "rock") %>% 
                                  mutate(genre = "rock") %>% 
                                  select(genre, name, id) 

rock_songs_features = get_track_audio_features(rock_songs$id)
rock_songs <- merge(rock_songs, rock_songs_features, by = "id")

pop_songs <- get_recommendations(limit = 100,
                                seed_genres = "pop") %>%
                                mutate(genre = "pop") %>%
                                select(genre, name, id)
pop_songs_features <- get_track_audio_features(pop_songs$id)
pop_songs <- merge(pop_songs, pop_songs_features, by = "id")

hip_hop_songs <- get_recommendations(limit = 100,
                                      seed_genres = "hip-hop") %>% 
                                      mutate(genre = "hip-hop") %>% 
                                      select(genre, name, id) 
hip_hop_songs_features <- get_track_audio_features(hip_hop_songs$id)
hip_hop_songs <- merge(hip_hop_songs, hip_hop_songs_features, by = "id")

country_songs <- get_recommendations(limit = 100,
                                     seed_genres = "country") %>%
                                     mutate(genre = "country") %>%
                                     select(genre, name, id)
country_songs_features <- get_track_audio_features(country_songs$id)
country_songs <- merge(country_songs, country_songs_features, by = "id")

classical_songs <- get_recommendations(limit = 100,
                                     seed_genres = "classical") %>%
                                     mutate(genre = "classical") %>%
                                     select(genre, name, id) 
classical_songs_features <- get_track_audio_features(classical_songs$id)
classical_songs <- merge(classical_songs, classical_songs_features, by = "id")

metal_songs <- get_recommendations(limit = 100,
                                       seed_genres = "metal") %>%
                                       mutate(genre = "metal") %>%
                                        select(genre, name, id)

metal_songs_features <- get_track_audio_features(metal_songs$id)
metal_songs <- merge(metal_songs, metal_songs_features, by = "id")
                                       

songs_df <- rbind(jazz_songs, rock_songs, pop_songs, hip_hop_songs,
                  country_songs, classical_songs, metal_songs)


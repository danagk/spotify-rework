# NOTE: DO NOT RUN THIS SCRIPT. It will take a long time and your computer will
#   get hot. Also, you'll need an API key saved in 'api-key.R'

# The dataframe this script creates is saved as 'country_data.csv' in ./data.
# It contains information on audio features of each top 50 song in every
#   country in which Spotify is available.
# This script is here to recreate the dataframe if needed.

# you need an (ignored) api-key.R file to access to Spotify API
library("spotifyr")
library("dplyr")
source("../scripts/api-key.R")

# create large data frame of all country's top 50 playlists
# country playlists were added to the user account for this project
playlists <- get_user_playlists("87ef2n9nxmaqpn38lsyh6hla3", limit = 50)

# make dataframe of playlists
playlists_df <- data_frame(
  playlist_name = playlists$name,
  playlist_id = playlists$id)

# make dataframe of tracks
seq <- 2:length(playlists_df$playlist_name)

tracks_df <- get_playlist_tracks(playlists_df$playlist_id[1]) %>%
  select(track.explicit, track.id, track.name, track.popularity)
tracks_df <- tracks_df %>%
  mutate(playlist_id = playlists_df$playlist_id[1])

for (i in seq) {
  tracks_temp <- get_playlist_tracks(playlists_df$playlist_id[i]) %>%
    select(track.explicit, track.id, track.name, track.popularity)
  tracks_temp <- tracks_temp %>%
    mutate(playlist_id = playlists_df$playlist_id[i])
  tracks_df <- bind_rows(tracks_df, tracks_temp)
}

# make data frame of track audio features
seq <- 2:length(tracks_df$track.name)

track_info <- get_track_audio_features(tracks_df$track.id[1])
track_info <- track_info %>%
  mutate(track.id = tracks_df$track.id[1])

for (i in seq) {
  track_info_temp <- get_track_audio_features(tracks_df$track.id[i])
  track_info_temp <- track_info_temp %>%
    mutate(track.id = tracks_df$track.id[i])
  track_info <- bind_rows(track_info, track_info_temp)
}

# remove repeated values
track_info <- distinct(track_info)

# join into one large dataframe
country_data <- merge(tracks_df, track_info, by = "track.id")
country_data <- merge(country_data, playlists_df, by = "playlist_id")

# write to csv
write.csv(country_data, file = "./country_data.csv", row.names = F)

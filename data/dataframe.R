songs_df <- read.csv("../data/SpotifyFeatures.csv", stringsAsFactors = FALSE) %>%
  # Filter genres that either do not have enough observations or we deemed
  # as irrelevant genres
  filter(genre != "A Capella" & genre != "Comedy" & 
           genre != "Movie" & genre != "Soundtrack")
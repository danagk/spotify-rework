# Histogram Chart --------------------------------------------------

# Create histogram of one specific feature of music (I chose danceability)
# on a single genre of Opera

# Extract the danceability of in all opera songs from the dataset
opera <- songs_df %>%
  select(genre, danceability) %>%
  filter(genre == "Opera")

# Create histogram on danceability of opera with titles and labels
histogram_opera <- ggplot(opera, aes(x = danceability)) +
  geom_histogram(
    binwidth = 0.05,
    color = "white",
    fill = rgb(0.2, 0.7, 0.1, 0.4)
  ) +
  ggtitle("Histogram of danceability of Opera") +
  xlab("Danceability") +
  theme_bw() +
  theme(plot.title = element_text(hjust = 0.5, face = "bold"))

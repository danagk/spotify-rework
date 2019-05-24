opera <- songs_df %>%
  select(genre, danceability) %>%
  filter(genre == "Opera")

histogram_opera <- ggplot(opera, aes(x=danceability)) + 
  geom_histogram(binwidth = 0.05, color="white", fill=rgb(0.2,0.7,0.1,0.4) ) +
  ggtitle("Histogram of danceability of Opera") +
  xlab("Danceability") +
  theme_bw() +
  theme(plot.title = element_text(hjust = 0.5, face = "bold"))



library("dplyr")
library("ggplot2")
source("main_data_frame.R")

# Bar Chart -------------------------------------------------------------------
genre_bar_chart <- songs_df %>%
  ggplot() +
  # Create bar chart with genre on the y axis and valence on the x axis
  # Order the valence from greatest to least
  geom_bar(aes(x = reorder(genre, valence), y = valence),
           stat = "summary", fun.y = "mean", # take the mean of the valence for
           # each genre
           fill = "#00CCCC") +
  coord_flip() + # Horizontal bar chart
  # title/axis labels
  ggtitle("Average Valence per Genre
          (based off Spotify list of 100 recommendations by genre)") +
  xlab("Genre") +
  ylab("Average Valence") +
  theme(axis.text.x = element_text(angle = 60, hjust = 1))
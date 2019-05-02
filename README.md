# Final Project (Brainstorm)

## Domain of Interest
### Our Interest
With the influences of popular culture in our everyday lives, our domain of interest is music. We are interested in the trends within music genres over time as well as where those trends originate from and how they influence social action. Using data from audio streaming platforms, such as Spotify, we hope to create meaningful visualizations of how trends in music develop, evolve, and invoke different behaviors.

### Other Examples of Data Driven Projects
1. [Sociologist Steven Stack found that higher exposure to country music resulted in increased suicidal thoughts and risks.](https://pdfs.semanticscholar.org/2938/15e43d8e9a8f96f1205401d6a51c8e095db4.pdf). Stack attributes this to country music themes that foster suicidal ideation such as marital strife and financial struggles. Stack has also studied the affects of blues, metal, and opera on suicide.
2. Silicon Valley Data Science created a [visualization of the history of rock and roll](https://svds.com/rockandroll/) by showing the influences between bands and statistics on 100 songs that represent rock music. Data visualization was done by using [GEPHI](https://gephi.org/) and [D3.JS](http://d3js.org/).
3. The Pudding designed an [interactive Billboard Top 100 visualization](https://pudding.cool/2017/03/music-history/index.html) that plays every #1 song from 1958 to 2016 to show how music taste has evolved over time. Users can toggle between years and search for specific artists.
4. Big Picture Group developed a [Music Timeline visualization](http://research.google.com/bigpicture/music/) to see how different musical genres became popular over time, and discover artists in each genre. The visualization is updated weekly to reflect new music.

### Data Driven Questions
1. What cities are trendsetters or early adopters in music taste? Does this change across genres or years? How do they influence other cities?
2. How do musical themes affect crime? Can we predict crime based on the type of music people listen to?
3. How do musical tastes/themes/lyrics change based on current events?
## Finding Data
1. [Spotify API](https://developer.spotify.com/documentation/web-api/)
2. [Crimes in Boston] (https://www.kaggle.com/ankkur13/boston-crime-data)
This dataset is made up of 2,60,760 observations and 17 features and contains records on crimes reported in Boston, MA from 2015-2018. Combined with the Spotify API, this dataset can be used to answer question 2 above, as we can see if the music being listened to corresponds with the crimes being committed. For example, if people are listening to songs with themes of robbery at a given time, will we see more thefts during this period?
3. [Billboard 1964-2015 Song + Lyrics](https://www.kaggle.com/rakannimer/billboard-lyrics/downloads/billboard-1964-2015-songs-lyrics.zip/1)
Originally collected by Kaylin Pavlik, which she shared on github. This dataset consists of lyrics from 50 years of Billboard Year-End Hot 100. There are 5100 observations and six features. This data set can be used to answer question 3 from above by comparing common themes/lyrics in songs corresponding to time and events.

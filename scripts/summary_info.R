# Summary Info Function -----------------------------------------------------

# Create a function that returns a list of information about the dataset
get_summary_info <- function(dataset) {
  ret <- list()
  ret$length <- length(dataset) # number of columns
  ret$num_obs <- nrow(dataset) # number of rows
  ret$col_names <- colnames(dataset) # column names
  ret$genres <- unique(dataset$genre) # the different genres
  # number of observations of each unique genres
  ret$num_of_each_genre <- table(dataset$genre)
  return(ret)
}

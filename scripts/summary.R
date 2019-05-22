library("spotifyr")
library("tidyverse")
library("knitr")
library("dplyr")
source("api_key.R")

Sys.setenv(SPOTIFY_CLIENT_ID = id_api_key)
Sys.setenv(SPOTIFY_CLIENT_SECRET = secret_api_key)

access_token <- get_spotify_access_token()
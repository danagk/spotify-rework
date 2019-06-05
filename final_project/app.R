# Load libraries so they are available
library("shiny")
library("dplyr")
source("./data/dataframe.R")
source("./data/country_data.R")
source("app_ui.R")
source("app_server.R")

# You will need to fill in the `app_ui.R` file to create the layout.
# Run the app through this file.
# Create a new `shinyApp()` using the loaded `ui` and `server` variables
shinyApp(ui = ui, server = server)
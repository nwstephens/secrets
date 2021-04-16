# This app uses a config file to detect the RStudio Connect environment

library(shiny)

options("keyring_backend" = "file")

pwd <- config::get("pwd")

ui <- fluidPage(
  pwd
)
server <- function(input, output, session) {
}
shinyApp(ui, server)

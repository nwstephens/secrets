library(shiny)

options("keyring_backend" = "file")

if(Sys.getenv("R_CONFIG_ACTIVE")=="rsconnect") {
  pwd <- Sys.getenv("test")
} else {
  pwd <- rstudioapi::askForSecret("test")
}

ui <- fluidPage(
  pwd
)
server <- function(input, output, session) {
}
shinyApp(ui, server)

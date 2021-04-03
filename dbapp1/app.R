#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(DBI)
library(rstudioapi)
library(keyring)

# set up the keyring and encrypt the password
# options("keyring_backend" = "file")
# keyring_create("psql")
# key_set("edupiata", "edupiata", keyring = "psql")

if(Sys.getenv("R_CONFIG_ACTIVE")=="rsconnect") {
  pwd <- Sys.getenv("pwd")
} else {
  options("keyring_backend" = "file")
  pwd <- key_get("edupiata", "edupiata", keyring = "psql")
}

con <- dbConnect(
  odbc::odbc(), 
  Driver="postgresql", 
  Server = "queenie.db.elephantsql.com", 
  Port = "5432", 
  Database = "edupiata", 
  UID = "edupiata", 
  PWD = pwd,
  BoolsAsChar = "0", 
  timeout = 10
)

faithful_data <- dbReadTable(con, "faithful")

# Define UI for application that draws a histogram
ui <- fluidPage(
  
  # Application title
  titlePanel("Old Faithful Geyser Data"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
      sliderInput("bins",
                  "Number of bins:",
                  min = 1,
                  max = 50,
                  value = 30)
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      plotOutput("distPlot")
    )
  )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
  
  output$distPlot <- renderPlot({
    # generate bins based on input$bins from ui.R
    x    <- faithful_data[, 2]
    bins <- seq(min(x), max(x), length.out = input$bins + 1)
    
    # draw the histogram with the specified number of bins
    hist(x, breaks = bins, col = 'darkgray', border = 'white')
  })
}

# Run the application 
shinyApp(ui = ui, server = server)

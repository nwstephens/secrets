#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

options("keyring_backend" = "file")

rsconnectAskForSecret <- function(
  name, 
  keyring_backend = "file",
  keyring = "system", 
  r_config_active = "rsconnect"
)
{
  if(Sys.getenv("R_CONFIG_ACTIVE")==r_config_active)
  {
    Sys.getenv(name)
  }
  else 
  {
    Sys.setenv("R_KEYRING_BACKEND" = keyring_backend)
    if(is.na(match(keyring, keyring::keyring_list()$keyring)))
    {
      keyring::keyring_create(keyring)
    }
    rstudioapi::askForSecret(name)
  }    
}  

library(DBI)
con <- dbConnect(
  odbc::odbc(), 
  Driver="postgresql", 
  Server = "queenie.db.elephantsql.com", 
  Port = "5432", 
  Database = "edupiata", 
  UID = "edupiata", 
  PWD = rsconnectAskForSecret("edupiata"),
  BoolsAsChar = "0", 
  timeout = 10
)
faithful_data <- dbReadTable(con, "faithful")

library(shiny)

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
#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

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
    x    <- faithful[, 2]
    bins <- seq(min(x), max(x), length.out = input$bins + 1)
    
    # draw the histogram with the specified number of bins
    hist(x, breaks = bins, col = 'darkgray', border = 'white')
  })
}

# Run the application 
shinyApp(ui = ui, server = server)

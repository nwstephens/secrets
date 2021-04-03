
library(DBI)

con <- dbConnect(
  odbc::odbc(), 
  Driver="postgresql", 
  Server = "queenie.db.elephantsql.com", 
  Port = "5432", 
  Database = "edupiata", 
  UID = "edupiata", 
  PWD = rstudioapi::askForPassword("Database password:"), 
  BoolsAsChar = "0", 
  timeout = 10
)


dbWriteTable(con, "faithful", faithful)
dbWriteTable(con, "mtcars", mtcars)

dw <- config::get("faithful")

dw$pwd

Sys.getenv("pwd")

con <- dbConnect(
  odbc::odbc(),
  Driver = dw$driver,
  Server = dw$server,
  Port = dw$port,
  Database = dw$database,
  UID = dw$uid,
  PWD = rstudioapi::askForPassword("Database password:"),
  BoolAsChar = dw$boolsAsChar,
  timeout = dw$timeout
)

faithful_data <- dbReadTable(con, "faithful")

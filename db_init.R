library(DBI)
con <- dbConnect(
  odbc::odbc(), 
  Driver="postgresql", 
  Server = "queenie.db.elephantsql.com", 
  Port = "5432", 
  Database = "edupiata", 
  UID = "edupiata", 
  PWD = rstudioapi::askForSecret("edupiata"),
  BoolsAsChar = "0", 
  timeout = 10
)
dbWriteTable(con, "faithful", faithful, overwrite = TRUE)
dbWriteTable(con, "mtcars", mtcars, overwrite = TRUE)

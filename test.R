
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

library(keyring)

default_backend()
has_keyring_support()
backend_env$new()$has_keyring_support()

keyring_create("foobar")
key_set_with_value("queenie.db.elephantsql.com", "edupiata", password = "R6q9H8KxW5T2BgAcnI3vsYOHwugko8Xc", keyring = "foobar")
key_get("queenie.db.elephantsql.com", "edupiata", keyring = "foobar")
key_list(keyring = "foobar")
keyring_delete(keyring = "foobar")
keyring_lock(keyring = "foobar")

con <- dbConnect(
  odbc::odbc(), 
  Driver="postgresql", 
  Server = "queenie.db.elephantsql.com", 
  Port = "5432", 
  Database = "edupiata", 
  UID = "edupiata", 
  PWD = key_get("queenie.db.elephantsql.com", "edupiata", keyring = "foobar"), 
  BoolsAsChar = "0", 
  timeout = 10
)


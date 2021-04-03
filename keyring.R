library(keyring)

### Store secrets encrypted at rest

options("keyring_backend" = "file")
keyring_create("kr")
key_set("foobar", keyring = "kr")
key_get("foobar", keyring = "kr")

### Store secrets in environment variables

options("keyring_backend" = "env")
key_set("foobar")
key_get("foobar")


### Store multiple secrets

options("keyring_backend" = "file")
keyring_create("DBs")

key_set("db1", "user", keyring = "DBs")
key_set_with_value("db2", "user", "password", keyring = "DBs")

keyring_lock("DBs")
keyring_unlock("DBs")

key_get("db1", "user", keyring = "DBs")
key_get("db2", "user", keyring = "DBs")


### Retrieve with RStudio

options("keyring_backend" = "file")
keyring::keyring_create("system")
rstudioapi::askForSecret("psql")

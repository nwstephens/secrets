# Set the file backend
options("keyring_backend" = "file")
Sys.setenv(R_KEYRING_BACKEND = "file")

# Create the system keyring
library(keyring)
keyring_create("system")

# Store and retrieve a secret (interactive).
rstudioapi::askForSecret("test")

# Store and retrieve a secret (non-interactive)
keyring_unlock("system")
key_set_with_value("RStudio Keyring Secrets", "user", "password", "system")
key_get("RStudio Keyring Secrets", "user", "system")
keyring_lock("system")

# View the system keyring
file.edit("~/.config/r-keyring/system.keyring")

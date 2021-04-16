# Encrypting secret data at rest with keyring and the file backend

The file backend for [keyring](https://github.com/r-lib/keyring) is useful for encrypting secret data at rest on Linux servers. This repos contains code that demonstrates how to use the keyring package to store secrets on RStudio Server [Pro] and deploy artifacts to RStudio Connect.

### Interactive example 

`rstudioapi::askForSecret()` prompts users to unlock, set, and retrieve secrets interactively in the RStudio IDE. If desired, those secrets are saved to file in a keyring with the following defaults:

* `service = RStudio Keyring Secrets`
* `keyring = system`
* `keyring_file = ~/.config/r-keyring/system.keyring`

```
# Set the file backend
options("keyring_backend" = "file")
Sys.setenv(R_KEYRING_BACKEND = "file")

# Create the system keyring
library(keyring)
keyring_create("system")

# Store and retrieve a secret (interactive).
rstudioapi::askForSecret("test")
```

### Non-interactive example

The keyring package contains many functions for operating directly with the keyring such as setting and retrieving secrets without interactive dialogs in the RStudio IDE.

```
# Store and retrieve a secret (non-interactive)
keyring_unlock("system")
key_set_with_value("RStudio Keyring Secrets", "user", "password", "system")
key_get("RStudio Keyring Secrets", "user", "system")
keyring_lock("system")
```

### File contents

By default, the keyrings are installed in `~/.config/r-keyring/`.

```
file.edit("~/.config/r-keyring/system.keyring")
```

Example:

```
keyring_info:
  keyring_version: 1.1.0
  nonce: e5c56041a114d7527d23a6846ce8e345869a28971692661d
  integrity_check: b9fd28443aebfa7e99a52bf5351cf4cdfad098fd68f3accdd5f5dad527d7c5d85d1f97587741
items:
- service_name: RStudio Keyring Secrets
  user_name: test
  secret: 1bf7978615164178f690cd3f90cdf29cedc898ea76e6acca
```

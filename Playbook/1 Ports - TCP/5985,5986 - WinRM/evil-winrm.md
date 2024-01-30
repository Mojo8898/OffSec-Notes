---
tags:
  - tool
  - winrm
---
# evil-winrm

Authenticate with WinRM

## Capabilities

### Authentication

```bash
# Username and password
evil-winrm -u devdoc -p '1g0tTh3R3m3dy!!' -i 10.129.44.75

# SSL
evil-winrm -i <remote-host> -S -c <cert> -k <priv-key>
```

### Session

```bash
# Display help menu
menu

# Upload file
upload <local-file>

# Download file
download <remote-file>

# Use scripts
Bypass-4MSI
<script>
```

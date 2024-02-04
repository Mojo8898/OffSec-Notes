---
tags:
  - tool
  - winrm
---
# evil-winrm

Authenticate with WinRM

## Capabilities

```bash
# Connect with credentials
evil-winrm -u username -p 'password' -i $IP

# Connect using SSL
evil-winrm -i $IP -S -c <cert> -k <priv-key>
```

### Session Commands

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

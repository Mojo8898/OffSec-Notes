# Methodology

## Connect

```bash
# Connect with credentials
evil-winrm -u devdoc -p '1g0tTh3R3m3dy!!' -i 10.129.44.75

# Connect using SSL
evil-winrm -i <remote-host> -S -c <cert> -k <priv-key>
```

**Useful session commands:**

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

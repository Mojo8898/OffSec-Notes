---
tags:
  - tool
  - routing
---
# proxychains

Proxy traffic

## Capabilities

Edit configuration at `/etc/proxychains4.conf`

```bash
# ... At the very bottom of the file, we set the ProxyList to only point to port 9999.
[ProxyList]
socks5 127.0.0.1 9999
```

We can use the proxy by adding the prefix `proxychains` to any command.

### Fundamentals

A SOCKS proxy is configured to listen on a specified port and hand off traffic to the specified destination. Think of it as a messenger that hands off post cards.

- `127.0.0.1` Only listen for processes running on the local host
- `0.0.0.0` Listen on all interfaces
- `<my_ip>` Listen on the specified interface
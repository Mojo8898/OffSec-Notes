# Methodology

```bash
# Passive local (ARP)
sudo netdiscover -i eth0 -p

# Active local (ARP)
sudo netdiscover -i eth0 -r 192.168.1.0/24

# Active local/remote
sudo nmap -sn 192.168.1.0/24
```

# Local Networking

## View

```bash
# View interface information
ip a
# Traditional
ifconfig

# View routing information
ip r
# Traditional
route -n
```

## Configure

```bash
# Assign an IP address space
sudo ip addr add 192.168.1.2/24 dev eth1
# Traditional
sudo ifconfig eth1 192.168.1.2 netmask 255.255.255.0

# Bring up an interface
sudo ip link set eth1 up

# Assign an IP address to an interface using DHCP
sudo dhclient eth1

# Create a virtual network interface (specified by "mode tun")
sudo ip tuntap add dev ligolo mode tun user kali
sudo ip link set ligolo up

# Set default gateway
sudo ip route add default via 192.168.1.1

# Add routing information to global routing table
sudo ip route add $TARGET_CIDR dev ligolo
sudo ip route add 10.10.20.0/24 via 192.168.1.1 dev eth1

# Cleanup a manual interface (automatically performed on reboot)
sudo ip link delete ligolo

# Connect to a wireless interface
wpa_passphrase $SSID $PASS > /etc/wpa_supplicant.conf
wpa_supplicant -B -i wlan0 -c /etc/wpa_supplicant.conf
```

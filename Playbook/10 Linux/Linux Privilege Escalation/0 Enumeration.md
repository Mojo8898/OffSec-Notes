# Enumeration

```bash
# Check sudo permissions, utilize GTFOBins to check any non-default configurations
sudo -l

# Find SUID/SGID Binaries
find / -user root -perm -4000 -exec ls -ldb {} \; 2>/dev/null
find / -user root -perm -6000 -exec ls -ldb {} \; 2>/dev/null

# Find files owned by target user
find / -user matt -type f -exec ls -ldb {} \; 2>/dev/null
find / -group matt -type f -exec ls -ldb {} \; 2>/dev/null

# Check commonly sensitive directories
ls /opt
ls /var/www

# Check processes
ps -ef

# Check Network information
netstat -tunlp
ip a
ip r
route
routel

# Find capabilities
/usr/sbin/getcap -r / 2>/dev/null

# Check iptables
cat /etc/iptables/rules.v4

# Inpsect incoming traffic for the string "pass"
sudo tcpdump -i lo -A | grep "pass"

# Check environment variables
env

# Check $PATH
echo $PATH

# Check crontab
cat /etc/crontab
ls -lah /etc/cron*
crontab -l
sudo crontab -l

# Check timers
systemctl list-timers --all

# Check writable directories/files
find / -path /proc -prune -o -type d -perm -o+w 2>/dev/null
find / -path /proc -prune -o -type f -perm -o+w 2>/dev/null

# Check drives that will be mounted at boot time
cat /etc/fstab

# List mounted filesystems
mount

# View all available disks
lsblk

# Check kernel (first string is the kernel version)
uname -a
cat /etc/lsb-release
cat /etc/issue

# Check for kernel exploits
# Given we know we are running 16.04.3 LTS (kernel 4.4.0-116-generic)
searchsploit "Linux Kernel Ubuntu 16.04 Local Privilege Escalation" | grep "4." | grep -v " < 4.4.0"

# List kernel module information
lsmod
/sbin/modinfo libata

# List installed applications
dpkg -l
```

## Binaries

- [linPEAS](https://github.com/carlospolop/PEASS-ng/releases/)
	- [linux-exploit-suggester.sh](https://raw.githubusercontent.com/The-Z-Labs/linux-exploit-suggester/master/linux-exploit-suggester.sh)
- [pspy](https://github.com/DominicBreuker/pspy/releases)

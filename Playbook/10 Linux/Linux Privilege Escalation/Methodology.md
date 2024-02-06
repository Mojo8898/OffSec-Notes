# Methodology

## Enumeration

```bash
# Gather general information
id
cat /etc/passwd
hostname

# Check sudo permissions, utilize GTFOBins to check any non-default configurations
sudo -l

# Find SUID/SGID Binaries
find / -user root -perm -4000 -exec ls -ldb {} \; 2>/dev/null
find / -user root -perm -6000 -exec ls -ldb {} \; 2>/dev/null

# Find files owned by target user/group
find / -user $USER -type f -exec ls -ldb {} \; 2>/dev/null
find / -group $USER -type f -exec ls -ldb {} \; 2>/dev/null

# Find writable files/directories
find / -writable -type f -exec ls -ldb {} \; 2>/dev/null
find / -writable -type d -exec ls -ldb {} \; 2>/dev/null

# Check commonly sensitive directories
ls /opt
ls /var/www

# Check processes
ps -ef

# Check Network information
netstat -tunlp
ip a
routel

# Check kernel/OS info
uname -a
cat /etc/issue
cat /etc/os-release
cat /etc/lsb-release

# Check iptables
cat /etc/iptables/rules.v4

# Check crontabs
cat /etc/crontab
ls -lah /etc/cron*
crontab -l
sudo crontab -l

# List installed applications
dpkg -l

# Check for unmounted drives
cat /etc/fstab    # Lists all drives that will be mounted at boot time
mount             # Lists all mounted filesystems
lsblk             # Lists all available disks

# List kernel module information
lsmod
/sbin/modinfo $MODULE

# Check environment variables
env

# Check .bashrc
cat ~/.bashrc

---

# Find capabilities
/usr/sbin/getcap -r / 2>/dev/null

# Inpsect incoming traffic for the string "pass"
sudo tcpdump -i lo -A | grep "pass"

# Check environment variables
env

# Check $PATH
echo $PATH

# Check timers
systemctl list-timers --all


```

## Automated Tools

**Primary:**

1. [linPEAS](https://github.com/carlospolop/PEASS-ng/releases/)
2. [pspy](https://github.com/DominicBreuker/pspy/releases)

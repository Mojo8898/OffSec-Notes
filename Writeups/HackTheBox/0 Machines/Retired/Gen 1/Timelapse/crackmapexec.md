Here I found that the `IPC$` and `Shares` shares have read permissions.
I disregarded `IPC$` as it is for null session connections.
```bash
➜  timelapse cme smb 10.10.11.152 -u 'guest' -p '' --shares
SMB         10.10.11.152    445    DC01             [*] Windows 10.0 Build 17763 x64 (name:DC01) (domain:timelapse.htb) (signing:True) (SMBv1:False)
SMB         10.10.11.152    445    DC01             [+] timelapse.htb\guest: 
SMB         10.10.11.152    445    DC01             [+] Enumerated shares
SMB         10.10.11.152    445    DC01             Share           Permissions     Remark
SMB         10.10.11.152    445    DC01             -----           -----------     ------
SMB         10.10.11.152    445    DC01             ADMIN$                          Remote Admin
SMB         10.10.11.152    445    DC01             C$                              Default share
SMB         10.10.11.152    445    DC01             IPC$            READ            Remote IPC
SMB         10.10.11.152    445    DC01             NETLOGON                        Logon server share 
SMB         10.10.11.152    445    DC01             Shares          READ            
SMB         10.10.11.152    445    DC01             SYSVOL                          Logon server share
```
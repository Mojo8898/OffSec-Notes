# HackTheBox
## Support
### Summary
- The box starts with typical enumeration, finding a strange file on the SMB share `support-tools` named `UserInfo.exe.zip`.
- Once decompressed, the file `UserInfo.exe` can be opened in `dnspy`, revealing an LDAP request that leaks LDAP credentials.
- The LDAP credentials can then be used to query LDAP and get credentials for user.
- We can then run `SharpHound` to see that the our current user is a member of a group with `GenericAll` over the current machine.
- This can be exploited by the following the `GenericAll Over a Computer` section of the [BloodHound Wiki](https://bloodhound.readthedocs.io/en/latest/data-analysis/edges.html) to get root.
### Skills Learned
- Active Directory structure consisting of objects with a hierarchy.
### Tools Learned
- `dnSpy`
- `ldapsearch`
- `Powermad`
- `PowerSploit`
- `impacket-getST`
- `impacket-psexec`
### Index
1. [enumeration](enumeration.md)
2. [foothold](foothold.md)
3. [privilege-escalation](privilege-escalation.md)
4. [proof](proof.md)
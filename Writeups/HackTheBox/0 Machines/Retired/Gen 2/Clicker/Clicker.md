---
Date: 2023-11-30
Platform: 
Difficulty: 
tags: 
Status: 
IP:
---
# Clicker

## Summary

- Text
- Text

### Key Takeaways

- Takeaway 1
- Takeaway 2

### Tools Used

- nmap

---

## Information Gathering

Scanned all TCP ports:

```shell
$ sudo nmap -p- --min-rate=1000 -oN nmap/example-allports -v 192.168.1.1
```

Enumerated open TCP ports:

```shell
$ sudo nmap -sC -sV -oN nmap/example-tcp -p 22,80 192.168.1.1
```

Enumerated top 200 UDP ports:

```shell
$ sudo nmap -sU --top-ports=200 -oN nmap/example-udp -v 192.168.1.1
```

![](Attachments/Pasted%20image%2020231202112134.png)

---

## Enumeration

### Port 80 - HTTP (Apache)

Text
Text

### Port 2049 - NFS (Apache)



---

## Exploitation

### Technique Used

Added comment after role

![](Attachments/Pasted%20image%2020231202150948.png)

![](Attachments/Pasted%20image%2020231202151023.png)

![](Attachments/Pasted%20image%2020231202151042.png)

We can change the extension in the export request to .php

![](Attachments/Pasted%20image%2020231202155351.png)

We can see that the nickname is reflected on the site, time to add it to the save_game query

![](Attachments/Pasted%20image%2020231202160452.png)

![](Attachments/Pasted%20image%2020231202160419.png)

![](Attachments/Pasted%20image%2020231202160556.png)

User: Jack



---

## Lateral Movement to User

### Local Enumeration

Text
Text

### Lateral Movement Vector

Text
Text

---

## Privilege Escalation

### Local Enumeration

Text
Text

### Privilege Escalation Vector

https://medium.com/@DGclasher/privilege-escalation-through-perl-environment-variables-349b39ca01

![](Attachments/Pasted%20image%2020231202171730.png)


---

## Trophy & Loot

user.txt

```bash
```

root.txt

```bash
```
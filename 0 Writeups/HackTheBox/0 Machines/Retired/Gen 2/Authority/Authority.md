---
Date: 2023-11-18
Platform: 
Difficulty: 
tags: 
Status: 
IP:
---
# Authority

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
$ sudo nmap -p- --min-rate=10000 -oA nmap/example-allports -v 192.168.1.1
```

Enumerated open TCP ports:

```shell
$ sudo nmap -sC -sV -oA nmap/example-tcp -p 22,80 192.168.1.1
```

Enumerated top 200 UDP ports:

```shell
$ sudo nmap -sU -oA nmap/example-udp -v 192.168.1.1
```

---

## Enumeration

### Port 53 - DNS

![](Attachments/Pasted%20image%2020231119001008.png)

### Port 80 - HTTP (Apache)

Text
Text

### Port 445 - SMB

`PWM/defaults/main.yml`:
![](Attachments/Pasted%20image%2020231119002428.png)

`PWM/ansible_inventory`:
![](Attachments/Pasted%20image%2020231119003600.png)

Cracking ansible passwords with: https://www.bengrewell.com/cracking-ansible-vault-secrets-with-hashcat/

![](Attachments/Pasted%20image%2020231119005151.png)

Responder after changing XML config

![](Attachments/Pasted%20image%2020231119011804.png)

---

## Exploitation

### Technique Used

Text
Text

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

Text
Text

---

## Trophy & Loot

user.txt

```bash
```

root.txt

```bash
```
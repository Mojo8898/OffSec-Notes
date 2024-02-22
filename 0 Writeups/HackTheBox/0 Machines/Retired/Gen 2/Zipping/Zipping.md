---
Date: 2023-11-17
Platform: Linux
Difficulty: Medium
tags: 
Status: Active
IP:
---
# Zipping

## Summary

- Text
- Text

### Key Takeaways

- Takeaway 1
- Takeaway 2

### Tools Used

- 
- 

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

### Port 80 - HTTP (Apache)

Discovered website on port 80

![](Attachments/Pasted%20image%2020231117155309.png)

![](Attachments/Pasted%20image%2020231117155340.png)

This "work with us" page clearly seemed to be the path forward due to it being a file-upload portal

---

## Exploitation

### Technique Used

Exploited LFI vulnerability using symlink technique discovered on hacktricks: https://book.hacktricks.xyz/pentesting-web/file-upload#symlink

![](Attachments/Pasted%20image%2020231117155102.png)

![](Attachments/Pasted%20image%2020231117155134.png)

![](Attachments/Pasted%20image%2020231117154947.png)

With the user "rektsu" we can grab the user flag

![](Attachments/Pasted%20image%2020231117170241.png)

![](Attachments/Pasted%20image%2020231117170311.png)

---

## Foothold

### Further Enumeration

`/var/www/html/shop/functions.php` reveals the MySQL database credentials:

![](Attachments/Pasted%20image%2020231117175316.png)

I then discovered the `preg_match` functions used to sanitize user input on the page `product.php` and `cart.php`

**product.php:**
![](Attachments/Pasted%20image%2020231117181513.png)

**cart.php:**
![](Attachments/Pasted%20image%2020231117181842.png)
![](Attachments/Pasted%20image%2020231117181907.png)



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
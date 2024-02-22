OS Type: Windows AD
Hostname: dc01
Domain Name: timelapse.htb
# TCP:
```bash
# Nmap 7.92 scan initiated Sun May 22 03:52:36 2022 as: nmap -sC -sV -T4 -p- -oA nmap/timelapse-all-ports 10.10.11.152
Nmap scan report for 10.10.11.152
Host is up (0.028s latency).
Not shown: 65519 filtered tcp ports (no-response)
PORT      STATE SERVICE       VERSION
53/tcp    open  domain        Simple DNS Plus
88/tcp    open  kerberos-sec  Microsoft Windows Kerberos (server time: 2022-05-22 15:54:11Z)
135/tcp   open  msrpc         Microsoft Windows RPC
139/tcp   open  netbios-ssn   Microsoft Windows netbios-ssn
389/tcp   open  ldap          Microsoft Windows Active Directory LDAP (Domain: timelapse.htb0., Site: Default-First-Site-Name)
445/tcp   open  microsoft-ds?
464/tcp   open  kpasswd5?
593/tcp   open  ncacn_http    Microsoft Windows RPC over HTTP 1.0
636/tcp   open  tcpwrapped
5986/tcp  open  ssl/http      Microsoft HTTPAPI httpd 2.0 (SSDP/UPnP)
|_ssl-date: 2022-05-22T15:55:41+00:00; +7h59m59s from scanner time.
| ssl-cert: Subject: commonName=dc01.timelapse.htb
| Not valid before: 2021-10-25T14:05:29
|_Not valid after:  2022-10-25T14:25:29
| tls-alpn: 
|_  http/1.1
|_http-server-header: Microsoft-HTTPAPI/2.0
|_http-title: Not Found
9389/tcp  open  mc-nmf        .NET Message Framing
49667/tcp open  msrpc         Microsoft Windows RPC
49673/tcp open  ncacn_http    Microsoft Windows RPC over HTTP 1.0
49674/tcp open  msrpc         Microsoft Windows RPC
49694/tcp open  msrpc         Microsoft Windows RPC
61993/tcp open  msrpc         Microsoft Windows RPC
Service Info: Host: DC01; OS: Windows; CPE: cpe:/o:microsoft:windows

Host script results:
| smb2-security-mode: 
|   3.1.1: 
|_    Message signing enabled and required
| smb2-time: 
|   date: 2022-05-22T15:55:01
|_  start_date: N/A
|_clock-skew: mean: 7h59m59s, deviation: 0s, median: 7h59m58s

Service detection performed. Please report any incorrect results at https://nmap.org/submit/ .
# Nmap done at Sun May 22 03:55:42 2022 -- 1 IP address (1 host up) scanned in 185.79 seconds
```
# UDP:
```bash
# Nmap 7.92 scan initiated Sun May 22 03:50:42 2022 as: nmap -sU -oA nmap/timelapse-udp 10.10.11.152
Nmap scan report for 10.10.11.152
Host is up (0.026s latency).
Not shown: 997 open|filtered udp ports (no-response)
PORT    STATE SERVICE
53/udp  open  domain
123/udp open  ntp
389/udp open  ldap

# Nmap done at Sun May 22 03:50:55 2022 -- 1 IP address (1 host up) scanned in 12.24 seconds
```
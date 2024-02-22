# TCP:
```bash
➜  opensource sudo nmap -sV -T4 -oA nmap/opensource 10.129.177.144                                                                                                                                                                          
Starting Nmap 7.92 ( https://nmap.org ) at 2022-05-22 12:06 EDT                                                                                                                                                                             
Stats: 0:00:09 elapsed; 0 hosts completed (1 up), 1 undergoing Service Scan                                                                                                                                                                 
Service scan Timing: About 50.00% done; ETC: 12:06 (0:00:06 remaining)                                                                                                                                                                      
Nmap scan report for 10.129.177.144                                                                                                                                                                                                         
Host is up (0.031s latency).                                                                                                                                                                                                                
Not shown: 997 closed tcp ports (reset)                                                                                                                                                                                                     
PORT     STATE    SERVICE VERSION                                                                                                                                                                                                           
22/tcp   open     ssh     OpenSSH 7.6p1 Ubuntu 4ubuntu0.7 (Ubuntu Linux; protocol 2.0)                                                                                                                                                      
80/tcp   open     http    Werkzeug/2.1.2 Python/3.10.3                                                                                                                                                                                      
3000/tcp filtered ppp
...
Service Info: OS: Linux; CPE: cpe:/o:linux:linux_kernel

Service detection performed. Please report any incorrect results at https://nmap.org/submit/ .
Nmap done: 1 IP address (1 host up) scanned in 91.64 seconds
```
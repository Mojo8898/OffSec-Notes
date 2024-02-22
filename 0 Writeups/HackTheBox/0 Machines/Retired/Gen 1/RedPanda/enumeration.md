## Enumeration
Lets start by scanning the machine with `Nmap`.
```bash
sudo nmap -sV -T4 -p- --min-rate=1000 $ip
```
![](Attachments/Pasted%20image%2020220827073837.png)
We find the following on the CSS page:
![](Attachments/Pasted%20image%2020220827063953.png)
We can also run `dirsearch`.
```bash
dirsearch -u $ip:8080 -o $PWD/disearch.out -t 100
```
![](Attachments/Pasted%20image%2020220827064106.png)
`/search` directory:
![](Attachments/Pasted%20image%2020220827064203.png)
`/stats` directory:
![](Attachments/Pasted%20image%2020220827064233.png)
Lets try curling with a single quote.
```bash
curl $ip:8080/search -d "name='"
```
![](Attachments/Pasted%20image%2020220827085627.png)
We can see that we are returned the html form for the single quote. This means SSTI.
We can research "Spring Boot SSTI" and click on the [first link](https://www.acunetix.com/blog/web-security-zone/exploiting-ssti-in-thymeleaf/)
We can then test the various expressions with `7*7` and find that our syntax is `*{...}`
![](Attachments/Pasted%20image%2020220827085930.png)
We can then use this format to check environment variables.
![](Attachments/Pasted%20image%2020220827090050.png)
We can now also use [this github repo](https://github.com/VikasVarshney/ssti-payload) to craft our own commands.

## Privilege Escalation
- `sudo -l` reveals the path forward
![](Attachments/Pasted%20image%2020231108203323.png)
- `systemctl status trail.service` reveals the location of `trail.service` to be `/etc/systemd/system/trail.service`
![](Attachments/Pasted%20image%2020231108204615.png)
- Checking [GTFOBins](https://gtfobins.github.io/gtfobins/systemctl/#sudo) for `systemctl` reveals that systemctl uses `less` as its default pager, allowing us to escalate to root if we shrink our terminal to force the shell to invoke the pager before running the command `sudo systemctl status trail.service`, followed by `!sh`.
![](Attachments/Pasted%20image%2020231108232330.png)
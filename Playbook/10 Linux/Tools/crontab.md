## crontab
Manages crontab (cron table) files for individual users
### Job Syntax
`<minute> <hour> <day/month> <month> <day/week> <command>`
### Key Flags
- `-l` List users crontab
- `-e` Edit users crontab
- `-r <crontab>` Remove crontab
### Examples
`sudo crontab -e`
- Edits `root` users crontab
### Additional Notes
- Run with `sudo` to specify root user
- [Cron visualizer](https://crontab.guru)
- 5 places crontabs are stored
	- User
	- Root
	- `/etc/cron.hourly`, `/etc/cron.daily`, etc
	- `/etc/crontab` (requires `sudo`)
	- `/etc/cron.d` (requires `sudo`)
- View crontab files for all users with
	- `cat /var/spool/cron/crontabs/*` for Ubuntu/Debian
	- `cat  /var/spool/cron/*` for Redhat, CentOS, Amazon Linux, Suse
---
[Home](Tool%20Index.md)
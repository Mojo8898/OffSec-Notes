---
tags:
  - port
---
# 80 - http

## Enumeration

![](Attachments/Pasted%20image%2020231218230307.png)

Directory enumeration:

- `corporate.htb`
	- `/analytics` 204 no content response
- `support.corporate.htb`
	- `POST` `/new` to create new support ticket
- `git.corporate.htb`
	- 403
- `sso.corporate.htb`
	- `/services`
- `people.corporate.htb`
	- Many 302 redirect for some kind of portal

![](Attachments/Pasted%20image%2020231219030747.png)

`http://sso.corporate.htb/services`

![](Attachments/Pasted%20image%2020231218232944.png)

`http://people.corporate.htb/auth/login` `session` cookie:

![](Attachments/Pasted%20image%2020231218233038.png)

XSS found in support page

`<img src="http://10.10.14.3/message"></img>`

![](Attachments/Pasted%20image%2020231219015650.png)

Unfortunately, a request was not received due to the strict CSP



## Vulnerabilities

Text
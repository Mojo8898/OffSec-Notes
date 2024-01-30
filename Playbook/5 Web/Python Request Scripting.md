# Python Request Scripting

## Scripting Requests

### Basic Script

```python
import requests

url = "https://target.htb"
payload = "test"
data = f"post_param={requests.utils.quote(payload)}"

try:
	r = requests.post(url, data=data)
	print(r.status_code)
	print(r.text)
except KeyboardInterrupt:
	exit()
except Exception as e:
	print(e)
```

Note: `requests.utils.quote(payload)` is used to automatically urlencode the payload in the case it contains special characters

### Send through burp

```python
import requests

url = "https://target.htb"
payload = "test"
data = f"post_param={requests.utils.quote(payload)}"

proxies = {                                                                                                          
    "http": "http://127.0.0.1:8080",                                                                                 
    "https": "https://127.0.0.1:8080",                                                                               
}

try:
	r = requests.post(url, data=data, proxies=proxies)
	print(r.status_code)
	print(r.text)
except KeyboardInterrupt:
	exit()
except Exception as e:
	print(e)
```

### SSL

Avoid issues with self-signed certificates by making the following modifications

```python
import requests
from urllib3.exceptions import InsecureRequestWarning
requests.packages.urllib3.disable_warnings(category=InsecureRequestWarning)

url = "https://target.htb:443"
payload = "test"
data = f"post_param={requests.utils.quote(payload)}"

try:
	r = requests.post(url, data=data, verify=False)
	print(r.status_code)
	print(r.text)
except KeyboardInterrupt:
	exit()
except Exception as e:
	print(e)
```

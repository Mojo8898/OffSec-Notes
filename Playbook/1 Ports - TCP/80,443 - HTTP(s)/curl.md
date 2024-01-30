---
tags:
  - tool
  - web
---
# curl

Query HTTP

## Capabilities

### GET Request

```bash
$ curl -v http://example.com
```

### POST Request

#### Normal

```bash
$ curl -v http://example.com/resource -d "param1=value1&param2=value2"
```

#### JSON

```bash
$ curl -v http://example.com -H 'Content-Type: application/json' -d '{"key1":"value1", "key2":"value2"}'
```

#### Multipart/Form-Data

```bash
$ curl -v http://example.com/upload -F "file=@localfile.txt"
```

---

## Additional Examples

### Send a post request with `data` and `cookie` content

```bash
$ curl http://example.com -b 'name=value'
```

### Follow redirects while deleting data from output to only show headers

```bash
$ curl -v 192.168.1.1 -L -o /dev/null
```

### Use credentials

```bash
$ curl -u username:password http://example.com
```

---

## Additional Information

- Specify request type with `-X RequestType`

- Refer to a file with `@data.txt`

- Specify user-agent with `-A MyUserAgent`

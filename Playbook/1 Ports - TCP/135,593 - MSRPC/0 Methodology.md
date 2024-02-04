# Methodology

## Enumerate

```bash
# Gather domain information
rpcinfo $DOMAIN
```

## Connect

```bash
# Attempt null authentication
rpcclient $IP -U ''

# Attempt guest authentication
rpcclient $IP
```

### Session Commands

```bash
# Enumerate users
enumdomusers
```

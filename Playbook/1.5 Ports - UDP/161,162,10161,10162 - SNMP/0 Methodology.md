# Methodology

## Enumerate

```bash
# Enumerate the public community string
snmpbulkwalk -Cr1000 -c public -v2c $TARGET_IP . > snmpwalk.out

# Grep output
cat snmpwalk.out | grep pass
grep -oP '::.*?\.' snmpwalk.out | sort | uniq -c | sort -n
grep hrSWRun snmpwalk.out | less -S
grep hrSWRun snmpwalk.out | grep $ID

# Brute force community strings
python3 snmpbrute.py -t $IP -f /usr/share/seclists/Discovery/SNMP/common-snmp-community-strings.txt
```

Note: Append the following OID's to the command in order to start enumerating at the relevant point

| 1.3.6.1.2.1.25.1.6.0 | System Processes |
| ---- | ---- |
| 1.3.6.1.2.1.25.4.2.1.2 | Running Programs |
| 1.3.6.1.2.1.25.4.2.1.4 | Processes Path |
| 1.3.6.1.2.1.25.2.3.1.4 | Storage Units |
| 1.3.6.1.2.1.25.6.3.1.2 | Software Name |
| 1.3.6.1.4.1.77.1.2.25 | User Accounts |
| 1.3.6.1.2.1.6.13.1.3 | TCP Local Ports |

---
tags:
---
# Elasticsearch

Analytics engine for all types of data

## Enumeration

Utilize `/_cat/*` enumerate different information

```bash
curl -k -u 'user:DumpPassword\$Here' https://127.0.0.1:9200/_cat/indices?v
```

Search an individual index with the query `/<index>/_search`

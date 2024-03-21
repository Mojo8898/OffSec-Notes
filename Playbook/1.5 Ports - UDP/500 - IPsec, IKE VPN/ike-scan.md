---
tags:
  - tool
  - ipsec
  - ike
---
# ike-scan

Query IPsec/IKE VPNs

## Capabilities

```bash
# Brute force possible transformations
for ENC in 1 2 3 4 5 6 7/128 7/192 7/256 8; do for HASH in 1 2 3 4 5 6; do for AUTH in 1 2 3 4 5 6 7 8 64221 64222 64223 64224 65001 65002 65003 65004 65005 65006 65007 65008 65009 65010; do for GROUP in 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18; do echo "--trans=$ENC,$HASH,$AUTH,$GROUP" >> ike-dict.txt ;done ;done ;done ;done

while read line; do (echo "Valid trans found: $line" && sudo ike-scan -M $line <IP>) | grep -B14 "1 returned handshake" | grep "Valid trans found" ; done < ike-dict.txt

# Attempt brute forcing with aggressive mode (a potentially vulnerable server-side setting)
while read line; do (echo "Valid trans found: $line" && ike-scan -M --aggressive -P handshake.txt $line <IP>) | grep -B7 "SA=" | grep "Valid trans found" ; done < ike-dict.txt


```

![](https://book.hacktricks.xyz/~gitbook/image?url=https:%2F%2F129538173-files.gitbook.io%2F%7E%2Ffiles%2Fv0%2Fb%2Fgitbook-legacy-files%2Fo%2Fassets%252F-L_2uGJGU7AVNRcqRvEi%252F-LrAjA5v34DHRwaP4f6m%252F-LrAn4UibcmZl7iUQRBV%252Fimage.png%3Falt=media%26token=92335027-c55a-43e4-9c01-5059675cea2a&width=768&dpr=4&quality=100&sign=0018536b6c5a7441a24718d27f6e76d34d6f8ceb8d6c8e224d48c01d73ad7bf6)
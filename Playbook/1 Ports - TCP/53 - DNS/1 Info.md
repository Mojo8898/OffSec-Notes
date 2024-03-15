# Info

### Record types

- `ns` Nameserver records contain the name of the authoritative servers hosting the DNS records for a domain.
- `a` Also known as a host record, the "_a record_" contains the IPv4 address of a hostname (such as offsec.local).
- `aaaa` Also known as a quad A host record, the "_aaaa record_" contains the IPv6 address of a hostname (such as offsec.local).
- `mx` Mail Exchange records contain the names of the servers responsible for handling email for the domain. A domain can contain multiple MX records.
- `ptr` Pointer Records are used in reverse lookup zones and can find the records associated with an IP address.
- `cname` Canonical Name Records are used to create aliases for other host records.
- `txt` Text records can contain any arbitrary data and be used for various purposes, such as domain ownership verification.
- `soa` Start of authority record.
- `srv` Service record.

### Priority values

Often seen with `mx` records, a lower value means higher priority

### Status Codes

- `NOERROR` Query successful
- `SERVFAIL` Query successful, but no data exists/data is invalid
- `NXDOMAIN` Name in question does not exist
- `REFUSED` Zone does not exist and connection refused

Note: If a server is running DNS over `tcp`, you can force `tcp` with the `+tcp` flag

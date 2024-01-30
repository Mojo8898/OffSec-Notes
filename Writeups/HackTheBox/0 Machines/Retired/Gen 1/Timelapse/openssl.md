The private key is stored to the file `timelapse.key`
```bash
➜  openssl openssl pkcs12 -in ../legacyy_dev_auth.pfx -nocerts -out timelapse.key
Enter Import Password:                                                                                                
Enter PEM pass phrase:  
Verifying - Enter PEM pass phrase:
```
The certificate is stored in `timelapse.crt`
```bash
➜  openssl openssl pkcs12 -in ../legacyy_dev_auth.pfx -clcerts -nokeys -out timelapse.crt
Enter Import Password:
```
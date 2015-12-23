#/bin/sh

# OpenSSL CA cert dir
CA_DIR=/etc/pki/CA/

# Setup the dir structure
cd $CA_DIR

for name in certs crl newcerts private csr; do
    [[ ! $name ]] || mkdir $name 
done

chmod 700 private
touch index.txt
echo 1000 > serial

# Create the root key and certificate

# Key
openssl genrsa -aes256 -out private/ca.key.pem 4096

chmod 400 private/ca.key.pem

# Certificate
openssl req -config /etc/pki/tls/openssl.cnf \
    -key private/ca.key.pem \
    -new -x509 -days 7300 -sha256 -extensions v3_ca \
    -out certs/ca.cert.pem

chmod 444 certs/ca.cert.pem



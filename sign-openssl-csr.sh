#!/bin/sh

# OpenSSL CA cert dir
TLS_DIR=/etc/pki/tls/

# Use first passed argument as hostname
fqdn=$1

if [ $# -ne 1 ]; then 
    echo "No hostname has been passed to the script."
    echo "Exiting."
    exit 1
fi

cd $TLS_DIR
openssl ca -config /etc/pki/tls/openssl.cnf \
      -extensions server_cert -days 1825 -notext -md sha256 \
      -in csr/${fqdn}.csr.pem \
      -out certs/${fqdn}.cert.pem

chmod 444 certs/${fqdn}.cert.pem

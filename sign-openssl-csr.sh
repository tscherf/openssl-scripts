#!/bin/sh

CA_DIR=/etc/pki/CA/
OPENSSL_CONF=/etc/pki/tls/openssl.cnf

# Use first argument as hostname
fqdn=$1

if [ $# -ne 1 ]; then
    echo "No hostname has been passed to the script."
    echo "Usage: $0 hostname"
    exit 1
fi

# sign the certificate request
openssl ca -config $OPENSSL_CONF \
      -extensions server_cert -days 1825 -notext -md sha256 \
      -in $CA_DIR/csr/${fqdn}.csr.pem \
      -out $CA_DIR/newcerts/${fqdn}.cert.pem

chmod 444 certs/${fqdn}.cert.pem

#!/bin/sh

CA_DIR=/etc/pki/CA/
OPENSSL_CONF=/etc/pki/tls/openssl.cnf

# Use first passed argument as hostname
fqdn=$1

if [ $# -ne 1 ]; then
    echo "No hostname has been passed to the script."
    echo "Usage: $0 hostname"
    exit 1
fi

# Create the key
openssl genrsa -aes256 \
    -out $CA_DIR/newcerts/private/${fqdn}.key.pem 2048

chmod 400 $CA_DIR/newcerts/private/${fqdn}.key.pem

# Create the signing request
openssl req -config $OPENSSL_CONF \
    -key $CA_DIR/newcerts/private/${fqdn}.key.pem \
    -new -sha256 -out $CA_DIR/csr/${fqdn}.csr.pem




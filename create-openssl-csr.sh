#!/bin/sh

# OpenSSL TLS cert dir
TLS_DIR=/etc/pki/tls/

# Use first passed argument as hostname
fqdn=$1

if [ $# -ne 1 ]; then 
    echo "No hostname has been passed to the script."
    echo "Exiting."
    exit 1
fi

# Setup the dir structure
cd $TLS_DIR

# Key
openssl genrsa -aes256 \
    -out private/${fqdn}.key.pem 2048

chmod 400 private/${fqdn}.key.pem

# CSR
[[ -d $TLS_DIR/csr/ ]] || mkdir $TLS_DIR/csr/

openssl req -config $TLS_DIR/openssl.cnf \
    -key private/${fqdn}.key.pem \
    -new -sha256 -out csr/${fqdn}.csr.pem




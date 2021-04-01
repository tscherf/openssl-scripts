#/bin/sh

CA_DIR=/etc/pki/CA/
OPENSSL_CONF=/etc/pki/tls/openssl.cnf

for name in certs private crl newcerts newcerts/private csr; do
    [[ ! $name ]] || mkdir $name
done

chmod 700 private
touch index.txt
echo 1000 > serial
echo 1000 > crlnumber


# Create the key
openssl genrsa -aes256 -out private/ca.key.pem 4096

chmod 400 private/ca.key.pem

# Create the certificate
openssl req -config $OPENSSL_CONF \
    -key $CA_DIR/private/ca.key.pem \
    -new -x509 -days 7300 -sha256 -extensions v3_ca \
    -out $CA_DIR/certs/ca.cert.pem

chmod 444 certs/ca.cert.pem



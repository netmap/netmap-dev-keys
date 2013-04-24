#!/bin/sh
# The script used to generate the development VM keys.

set -o errexit  # Stop the script on the first error.
set -o nounset  # Catch un-initialized variables.

# OpenSSL state.
mkdir -p tmp
echo "01" > tmp/serial
echo -n "" > tmp/index.txt

# CA key and self-signed certificate.
openssl req -config script/openssl.cnf -x509 -nodes -days 3650 -newkey rsa:2048 \
    -out _ca.cer -outform PEM -keyout _ca.pem -keyform PEM \
    -subj "/C=US/ST=Massachusetts/L=Cambridge/O=MIT CSAIL/OU=NetMap Dev Keys/CN=Dev CA"


# Game server key and certificate signing request.
openssl req -nodes -newkey rsa:2048 -sha1 \
    -out game.csr -outform PEM -keyout game.pem -keyform PEM \
    -subj "/C=US/ST=Massachusetts/L=Cambridge/O=MIT CSAIL/OU=NetMap Dev Keys/CN=netmap.local"

# Game server certificate.
openssl ca -config script/openssl.cnf -batch -cert _ca.cer -keyfile _ca.pem \
    -md sha1 -days 3650 -in game.csr -out game.cer -outdir tmp -notext
rm game.csr
cat game.cer _ca.cer > game.crt
rm game.cer

# Metrics server key and certificate signing request.
openssl req -nodes -newkey rsa:2048 -sha1 \
    -out metrics.csr -outform PEM -keyout metrics.pem -keyform PEM \
    -subj "/C=US/ST=Massachusetts/L=Cambridge/O=MIT CSAIL/OU=NetMap Dev Keys/CN=netmap.local:8443"

# Metrics server certificate
openssl ca -config script/openssl.cnf -batch -cert _ca.cer -keyfile _ca.pem \
    -md sha1 -days 3650 -in metrics.csr -out metrics.cer -outdir tmp -notext
rm metrics.csr
cat metrics.cer _ca.cer > metrics.crt
rm metrics.cer

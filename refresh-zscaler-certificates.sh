#!/usr/bin/env bash

echo "Refreshing ZScaler Certificates"
DIR_NAME=$(mktemp --directory -t zscaler-certs-XXXXXXXXXX)
mkdir --parents "${DIR_NAME}"
openssl s_client -showcerts -verify 5 -connect www.google.com:443 -servername www.google.com < /dev/null \
  | awk --assign dir="$DIR_NAME" '/BEGIN/,/END/{ if(/BEGIN/){a++}; out=dir"/zscaler-cert"a".crt"; print >out}'
mkdir -p /usr/local/share/ca-certificates/extra
cp "${DIR_NAME}"/*.crt /usr/local/share/ca-certificates/extra/

#COPY my-cert.pem /usr/local/share/ca-certificates/my-cert.crt

ls -lisa  /usr/local/share/ca-certificates/extra/*.crt
#cat "${DIR_NAME}"/*.crt >> /etc/ssl/certs/ca-certificates.crt 

#update-ca-certificates
rm -R -f "${DIR_NAME}"


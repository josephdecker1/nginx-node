#!/bin/bash

# wait for certbot to run and then replace the configuration file for nginx

set -e

# creating dir for certs for later
mkdir -p dhparam

cp nginx/nginx.initial.conf nginx/nginx.conf

docker-compose up -d


[ -f dhparam/dhparam-2048.pem ] && echo "Found openssl file. Skipping" || echo "OpenSSL not found. Creating..." && sudo openssl dhparam -out dhparam/dhparam-2048.pem 2048

echo "sleeping for 5"
sleep 5

docker-compose stop nginx

echo "sleeping for 5"
sleep 5

rm nginx/nginx.conf 
cp nginx/nginx.final.conf nginx/nginx.conf

docker-compose up -d --force-recreate --no-deps nginx

docker-compose ps

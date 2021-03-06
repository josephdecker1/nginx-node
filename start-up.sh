#!/bin/bash

# wait for certbot to run and then replace the configuration file for nginx

set -ex

# creating dir for certs for later
mkdir -p dhparam

cp nginx/nginx.initial.conf nginx/nginx.conf

docker-compose up -d

if [ -f dhparam/dhparam-2048.pem ]
then
	echo "Found openssl file. Skipping"
else
	echo "OpenSSL not found. Creating..."
  sudo openssl dhparam -out dhparam/dhparam-2048.pem 2048
fi


echo "sleeping for 15"
sleep 15

docker-compose stop nginx
docker-compose logs certbot

echo "sleeping for 15"
sleep 15

rm nginx/nginx.conf 
cp nginx/nginx.final.conf nginx/nginx.conf

docker-compose up -d --force-recreate --no-deps nginx

docker-compose ps

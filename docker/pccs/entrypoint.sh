#!/bin/bash

EHSM_PCCS_PORT=$EHSM_PCCS_PORT
EHSM_PCCS_API_KEY=$EHSM_PCCS_API_KEY
EHSM_PCCS_USER_PASSWORD=${EHSM_PCCS_USER_PASSWORD}
EHSM_PCCS_ADMIN_PASSWORD=${EHSM_PCCS_ADMIN_PASSWORD}

# Step 1. Generate certificates to use with PCCS
mkdir /opt/intel/pccs/ssl_key
cd /opt/intel/pccs/ssl_key
openssl genrsa -out private.pem 3072
openssl req -new -key private.pem -out csr.pem \
        -subj "/C=$EHSM_CONFIG_OPENSSL_COUNTRYNAME/ST=$EHSM_CONFIG_OPENSSL_LOCALITYNAME/L=$EHSM_CONFIG_OPENSSL_LOCALITYNAME/O=$EHSM_CONFIG_OPENSSL_ORGANIZATIONNAME/OU=$EHSM_CONFIG_OPENSSL_ORGANIZATIONNAME/CN=$EHSM_CONFIG_OPENSSL_COMMONNAME/emailAddress=$EHSM_CONFIG_OPENSSL_EMAILADDRESS/" -passout pass:$EHSM_CONFIG_OPENSSL_SERVER_CERT_PASSWORD
openssl x509 -req -days 365 -in csr.pem -signkey private.pem -out file.crt
rm -rf csr.pem
chmod 644 ../ssl_key/*
ls ../ssl_key

# Step 2. Set default.json to be under ssl_key folder and fill the parameters
cd /opt/intel/pccs/config/

userTokenHash=$(echo -n $EHSM_PCCS_USER_PASSWORD | sha512sum | tr -d '[:space:]-')
adminTokenHash=$(echo -n $EHSM_PCCS_ADMIN_PASSWORD | sha512sum | tr -d '[:space:]-')
PCCS_HOST_IP=0.0.0.0

sed -i "s/YOUR_HTTPS_PORT/$EHSM_PCCS_PORT/g" default.json
sed -i "s/YOUR_HOST_IP/$PCCS_HOST_IP/g" default.json
sed -i "s/YOUR_USER_PASSWORD/$EHSM_PCCS_USER_PASSWORD/g" default.json
sed -i 's@YOUR_PROXY@'"$http_proxy"'@' default.json
sed -i "s/YOUR_USER_TOKEN_HASH/$userTokenHash/g" default.json
sed -i "s/YOUR_ADMIN_TOKEN_HASH/$adminTokenHash/g" default.json
sed -i "s/YOUR_API_KEY/$EHSM_PCCS_API_KEY/g" default.json
chmod 644 default.json
cd /opt/intel/pccs/

# Step 3. Start PCCS service and keep listening
/usr/bin/node pccs_server.js

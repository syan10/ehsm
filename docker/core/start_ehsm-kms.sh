#!/bin/bash
echo '# PCCS server address' > /etc/sgx_default_qcnl.conf
echo 'PCCS_URL='${PCCS_URL}'/sgx/certification/v3/' >> /etc/sgx_default_qcnl.conf
echo '# To accept insecure HTTPS certificate, set this option to FALSE' >> /etc/sgx_default_qcnl.conf
echo 'USE_SECURE_CERT=FALSE' >> /etc/sgx_default_qcnl.conf

node /home/ehsm/ehsm_kms_service/ehsm_kms_server.js

for i in {1..10}
do
    curl -v -k -G "${PCCS_URL}/sgx/certification/v3/rootcacrl" &> /dev/null
    if (( $?==0 ))
    then
        node /home/ehsm/ehsm_kms_service/ehsm_kms_server.js
        break
    else
        echo "pccs not ready, sleep 1s then try to connect it again..."
        sleep 1
    fi
done
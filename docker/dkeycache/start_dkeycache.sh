#!/bin/bash

set -x

echo '# PCCS server address' > /etc/sgx_default_qcnl.conf
echo 'PCCS_URL='${PCCS_URL}'/sgx/certification/v3/' >> /etc/sgx_default_qcnl.conf
echo '# To accept insecure HTTPS certificate, set this option to FALSE' >> /etc/sgx_default_qcnl.conf
echo 'USE_SECURE_CERT=FALSE' >> /etc/sgx_default_qcnl.conf


start_cmd="/home/ehsm/out/ehsm-dkeycache/ehsm-dkeycache -i ${DKEYSERVER_IP} -p ${DKEYSERVER_PORT}"

for i in {1..10}
do
    curl -v -k -G "${PCCS_URL}/sgx/certification/v3/rootcacrl" &> /dev/null
    if (( $?==0 ))
    then
        for j in {1..10}
        do
            /home/ehsm/out/ehsm-dkeycache/ehsm-dkeycache -i ${DKEYSERVER_IP} -p ${DKEYSERVER_PORT}
            if (( $?==0 ))
            then
                break
            else
                sleep 1
                echo "dkeyserver not ready, sleep 1s then try to connect it again..."
            fi
        done

        break
    else
        echo "pccs not ready, sleep 1s then try to connect it again..."
        sleep 1
    fi
done


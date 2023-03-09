#!/bin/bash

set -x

echo '# PCCS server address' > /etc/sgx_default_qcnl.conf
echo 'PCCS_URL='${PCCS_URL}'/sgx/certification/v3/' >> /etc/sgx_default_qcnl.conf
echo '# To accept insecure HTTPS certificate, set this option to FALSE' >> /etc/sgx_default_qcnl.conf
echo 'USE_SECURE_CERT=FALSE' >> /etc/sgx_default_qcnl.conf


start_cmd="/home/ehsm/out/ehsm-dkeyserver/ehsm-dkeyserver -r ${DKEYSERVER_ROLE}"
if [ ${TARGET_IP} ]; then
   start_cmd="/home/ehsm/out/ehsm-dkeyserver/ehsm-dkeyserver -r ${DKEYSERVER_ROLE}  -i ${TARGET_IP} -p ${TARGET_PORT}"
elif [ ${TARGET_URL} ]; then
   start_cmd="/home/ehsm/out/ehsm-dkeyserver/ehsm-dkeyserver -r ${DKEYSERVER_ROLE}  -u ${TARGET_URL} -p ${TARGET_PORT}"
fi


for i in {1..10}
do
    curl -v -k -G "${PCCS_URL}/sgx/certification/v3/rootcacrl" &> /dev/null
    if (( $?==0 ))
    then
        $start_cmd
        break;
    else
        echo "pccs not ready, sleep 1s then try to connect it again..."
        sleep 1
    fi
done

# cat /etc/sgx_default_qcnl.conf

# echo $start_cmd

# $start_cmd

#echo $start_cmd

#$start_cmd

#tail -f /dev/null
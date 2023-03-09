#!/bin/bash
set -x

PCCS_URL=https://10.112.240.169:8800

for i in {1..10}
do
    curl -v -k -G "${PCCS_URL}/sgx/certification/v3/rootcacrl" &> /dev/null
    if (( $?==0 ))
    then
        echo "ready!"
        break
    else
        echo "not ready!"
        sleep 1
    fi
done
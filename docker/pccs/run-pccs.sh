export EHSM_PCCS_IMAGE_NAME=your_pccs_image_name #ehsm-pccs
export EHSM_PCCS_IMAGE_VERSION=your_pccs_image_version #0.1.0
export EHSM_PCCS_CONTAINER_NAME=your_pccs_container_name_to_run #ehsm-pccs

export EHSM_PCCS_PORT=pccs_port_to_use #8800
export EHSM_PCCS_API_KEY=your_intel_pcs_server_subscription_key_obtained_through_web_registeration
export EHSM_PCCS_USER_PASSWORD=a_password_for_pccs_user
export EHSM_PCCS_ADMIN_PASSWORD=a_password_for_pccs_admin

export http_proxy=your_http_proxy
export https_proxy=your_https_proxy

# The above parameters are used to init pccs server
export EHSM_CONFIG_OPENSSL_COUNTRYNAME=your_country_name #CN
export EHSM_CONFIG_OPENSSL_LOCALITYNAME=your_city_name #SH
export EHSM_CONFIG_OPENSSL_ORGANIZATIONNAME=your_organizaition_name #intel
export EHSM_CONFIG_OPENSSL_COMMONNAME=server_fqdn_or_your_name #ehsm
export EHSM_CONFIG_OPENSSL_EMAILADDRESS=your_email_address #ehsm@intel.com
export EHSM_CONFIG_OPENSSL_SERVER_CERT_PASSWORD=your_server_cert_password_to_use

docker run -itd \
--net=host \
--name $EHSM_PCCS_CONTAINER_NAME \
-e EHSM_PCCS_PORT=$EHSM_PCCS_PORT \
-e EHSM_PCCS_API_KEY=$EHSM_PCCS_API_KEY \
-e EHSM_PCCS_USER_PASSWORD=$EHSM_PCCS_USER_PASSWORD \
-e EHSM_PCCS_ADMIN_PASSWORD=$EHSM_PCCS_ADMIN_PASSWORD \
-e EHSM_CONFIG_OPENSSL_COUNTRYNAME=$EHSM_CONFIG_OPENSSL_COUNTRYNAME \
-e EHSM_CONFIG_OPENSSL_LOCALITYNAME=$EHSM_CONFIG_OPENSSL_LOCALITYNAME \
-e EHSM_CONFIG_OPENSSL_ORGANIZATIONNAME==$EHSM_CONFIG_OPENSSL_ORGANIZATIONNAME \
-e EHSM_CONFIG_OPENSSL_COMMONNAME=$EHSM_CONFIG_OPENSSL_COMMONNAME \
-e EHSM_CONFIG_OPENSSL_EMAILADDRESS=$EHSM_CONFIG_OPENSSL_EMAILADDRESS \
-e SERVER_CERT_PASSWORD=$SERVER_CERT_PASSWORD \
-d $EHSM_CONFIG_OPENSSL_SERVER_CERT_PASSWORD:$EHSM_CONFIG_OPENSSL_SERVER_CERT_PASSWORD

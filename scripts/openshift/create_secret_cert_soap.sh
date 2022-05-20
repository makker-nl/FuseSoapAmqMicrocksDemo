#!/bin/bash
#
# Create a secret from a keystore and a truststore
# @author: Martien van den Akker, Virtual Sciences | Concolusion
#
# History:
# 2022-01-27, Martien van den Akker, Initial Creation
#
SCRIPTPATH=$(dirname $0)
BASEDIR=$SCRIPTPATH/../..
set -euo pipefail
#
. $SCRIPTPATH/oc_env.sh
. $SCRIPTPATH/keystore_env.sh
#
SECRET_CERT_TPL=$SCRIPTPATH/secret_cert.yml.tpl
SOAP_SECRET_CERT_YML=$SCRIPTPATH/${SOAP_CERT_SECRET_NAME}.yml
#
main () {
  echo "Create secret for keystore ${SOAP_KEY_STORE} and truststore ${TRUST_STORE}"
  export KEYSTORE_B64=$(cat ${SOAP_KEY_STORE} | base64 -w 0)
  export KEYSTORE_PWD_B64=$(echo -n "${SOAP_KEYSTORE_PWD}" | base64)
  export CERT_SECRET_NAME=$SOAP_CERT_SECRET_NAME
  #
  export TRUSTSTORE_B64=$(cat ${TRUST_STORE} | base64 -w 0)
  export TRUSTSTORE_PWD_B64=$(echo -n ${TRUSTSTORE_PWD} | base64 )
  #
  echo Substitute $SECRET_CERT_TPL to $SOAP_SECRET_CERT_YML
  envsubst < $SECRET_CERT_TPL > $SOAP_SECRET_CERT_YML
  #   
}

main "$@"


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
. $SCRIPTPATH/keystore_env.sh
#
export NS=ns-cci-poc-obis-brokers
SECRET_CERT_TPL=$SCRIPTPATH/secret_cert.yml
ROS_SECRET_CERT_YML=$SCRIPTPATH/${ROS_CERT_SECRET_NAME}.yml
#
main () {
  echo "Create secret for keystore ${ROS_KEY_STORE} and truststore ${TRUST_STORE}"
  export KEYSTORE_B64=$(cat ${ROS_KEY_STORE} | base64 -w 0)
  export KEYSTORE_PWD_B64=$(echo -n "${ROS_KEYSTORE_PWD}" | base64)
  export CERT_SECRET_NAME=$ROS_CERT_SECRET_NAME
  #
  export TRUSTSTORE_B64=$(cat ${TRUST_STORE} | base64 -w 0)
  export TRUSTSTORE_PWD_B64=$(echo -n ${TRUSTSTORE_PWD} | base64 )
  #
  echo Substitute $SECRET_CERT_TPL to $ROS_SECRET_CERT_YML
  envsubst < $SECRET_CERT_TPL > $ROS_SECRET_CERT_YML
  #   
}

main "$@"


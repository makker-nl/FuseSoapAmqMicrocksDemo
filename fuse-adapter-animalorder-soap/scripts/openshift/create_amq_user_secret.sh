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
PASSWORD=jolololokia
USER=mr-miyagi
export USER_SECRET_NAME=max-adapter-activity-max-amq-broker-secret
#
SECRET_CERT_TPL=$SCRIPTPATH/secret_user.yml
SECRET_CERT_YML=$SCRIPTPATH/${USER_SECRET_NAME}.yml
#
main () {
  echo "Create secret for user ${USER} and password ${USER}"
  export USER_B64=$(echo ${USER} | base64 -w 0)
  export PASSWORD_B64=$(echo ${PASSWORD} | base64 -w 0)
  #
  echo Substitute $SECRET_CERT_TPL to $SECRET_CERT_YML
  envsubst < $SECRET_CERT_TPL > $SECRET_CERT_YML
  #   
}

main "$@"


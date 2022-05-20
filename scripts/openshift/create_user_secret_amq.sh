#!/bin/bash
#
# Create a secret for a user
# @author: Martien van den Akker, Virtual Sciences | Concolusion
#
# History:
# 2022-04-22, Martien van den Akker, Initial Creation
#
SCRIPTPATH=$(dirname $0)
BASEDIR=$SCRIPTPATH/../..
set -euo pipefail
#
. $SCRIPTPATH/oc_env.sh
. $SCRIPTPATH/keystore_env.sh
#
USER=$AMQP_USER
PASSWORD=$AMQP_PASSWORD
export USER_SECRET_NAME=$AMQP_USER_SECRET_NAME
#
SECRET_CERT_TPL=$SCRIPTPATH/secret_user.yml.tpl
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


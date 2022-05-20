#!/bin/bash
#
# Create a deployment for the fuse animal order soap adapter
# @author: Martien van den Akker, Virtual Sciences | Concolusion
#
# History:
# 2022-05-20, Martien van den Akker, Initial Creation
#
SCRIPTPATH=$(dirname $0)
BASEDIR=$SCRIPTPATH/../..
set -euo pipefail
#
. $SCRIPTPATH/oc_env.sh
. $SCRIPTPATH/keystore_env.sh
. $SCRIPTPATH/adapter_soap_env.sh
#
export CERT_SECRET_NAME=$SOAP_CERT_SECRET_NAME
#
main () {
  echo Substitute $DEPLOYMENT_P1_TPL, $DEPLOYMENT_ENV_TPL, $DEPLOYMENT_P2_TPL  to $DEPLOYMENT_YML
  cat $SCRIPTPATH/$DEPLOYMENT_P1_TPL $SCRIPTPATH/$DEPLOYMENT_ENV_TPL $SCRIPTPATH/$DEPLOYMENT_P2_TPL | envsubst > $DEPLOYMENT_YML
  echo Substitute $SERVICE_TPL to $SERVICE_YML
  envsubst < $SERVICE_TPL > $SERVICE_YML
  echo Substitute $ROUTE_TPL to $ROUTE_YML
  envsubst < $ROUTE_TPL > $ROUTE_YML
}

main "$@"


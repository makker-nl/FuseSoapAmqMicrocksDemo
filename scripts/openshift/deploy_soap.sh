#!/bin/bash
#
# Create a deployment for an app
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
. $SCRIPTPATH/adapter_soap_env.sh
#
SOAP_SECRET_CERT_YML=$SCRIPTPATH/${SOAP_CERT_SECRET_NAME}.yml
AMQP_SECRET_CERT_YML=$SCRIPTPATH/$AMQP_USER_SECRET_NAME.yml
#
main () {
  echo Create secret $SOAP_SECRET_CERT_YML
  oc create -f $SOAP_SECRET_CERT_YML
  echo Create secret $AMQP_SECRET_CERT_YML
  oc create -f $AMQP_SECRET_CERT_YML
  echo Create deployment for YAML: $DEPLOYMENT_YML
  oc create -f $DEPLOYMENT_YML
  echo Create service for YAML: $SERVICE_YML
  oc create -f $SERVICE_YML
  echo Create route for YAML: $ROUTE_YML
  oc create -f $ROUTE_YML
}

main "$@"


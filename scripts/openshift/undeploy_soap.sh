#!/bin/bash
#
#  Delete application from OpenShift
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
  echo Delete secret $SOAP_SECRET_CERT_YML
  oc delete -f $SOAP_SECRET_CERT_YML
  echo Delete secret $AMQP_SECRET_CERT_YML
  oc delete -f $AMQP_SECRET_CERT_YML
  echo Delete deployment for YAML: $DEPLOYMENT_YML
  oc delete -f $DEPLOYMENT_YML
  echo Delete service for YAML: $SERVICE_YML
  oc delete -f $SERVICE_YML
  echo Delete route for YAML: $ROUTE_YML
  oc delete -f $ROUTE_YML
}

main "$@"


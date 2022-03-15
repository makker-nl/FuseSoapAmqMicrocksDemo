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
. $SCRIPTPATH/keystore_env.sh
#
export NS=ns-cci-poc-obis-brokers
export APP_NAME=max-adapter-activity-ros
export DEPL_NAME=${APP_NAME}
# Route moet nog aangemaakt worden.
export AMQP_REMOTEURI=amqp://max-broker-ss-0:5672
export AMQP_USERNAME=mr-miyagi
export AMQP_PASSWORD_SECRET=max-adapter-activity-max-amq-broker-secret
export IMAGE=hipdevcontainerregistry001.azurecr.io/max/adapter-activity-ros:20220105.4
export USER_SECRET_NAME=max-adapter-activity-max-amq-broker-secret
export DEPLOYMENT_TPL=deployment_ros.yml
export DEPLOYMENT_YML=deployment_${DEPL_NAME}.yml
export SERVICE_TPL=service_ros.yml
export SERVICE_YML=service_${DEPL_NAME}.yml
export ROUTE_TPL=route_ros.yml
export ROUTE_YML=route_${DEPL_NAME}.yml
#
main () {
  echo Substitute $DEPLOYMENT_TPL to $DEPLOYMENT_YML
  envsubst < $DEPLOYMENT_TPL > $DEPLOYMENT_YML
  echo Substitute $SERVICE_TPL to $SERVICE_YML
  envsubst < $SERVICE_TPL > $SERVICE_YML
  echo Substitute $ROUTE_TPL to $ROUTE_YML
  envsubst < $ROUTE_TPL > $ROUTE_YML
}

main "$@"


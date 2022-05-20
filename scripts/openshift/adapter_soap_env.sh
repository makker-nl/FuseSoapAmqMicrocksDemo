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
export APP_NAME=fuse-adapter-animalorder-soap
export APP_VERSION=1.0.0-SNAPSHOT
#
export DEPL_NAME=${APP_NAME}
export DEPLOYMENT_YML=deployment_${DEPL_NAME}.yml
export DEPLOYMENT_ENV_TPL=deployment_soap-env.yml.tpl
export SERVICE_YML=service_${DEPL_NAME}.yml
export ROUTE_YML=route_${DEPL_NAME}.yml
export SERVICE_NAME=${DEPL_NAME}
export SERVICE_PORT_NAME=http-soap
export SERVICE_PORT=8443
export SERVICE_TARGET_PORT=${SERVICE_PORT}
export SERVICE_YML=service_${SERVICE_NAME}.yml
export ROUTE_NAME=${DEPL_NAME}
export ROUTE_YML=route_${ROUTE_NAME}.yml
export AMQP_SERVICE_ADDRESS=topic:pubsub.max.roosters

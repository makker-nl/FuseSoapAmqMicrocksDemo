#!/bin/bash
#
# Set OC Enviroment
# @author: Martien van den Akker, Virtual Sciences | Concolusion
#
# History:
# 2022-04-22, Martien van den Akker, Initial Creation
#
SCRIPTPATH=$(dirname $0)
#
if [ -z ${BASEDIR+x} ]; then BASEDIR=$SCRIPTPATH/../.. ; fi
#
set -euo pipefail
#
export NS=fuse-microcks-demo
export IMG_REG_URL=default-route-openshift-image-registry.apps.test-cluster.vs-cloud.nl
export AMQP_REMOTEURI=amqp://fuse-amq-broker-amqp-0-svc:5672
#
export DEPLOYMENT_P1_TPL=deployment.yml.part1.tpl
export DEPLOYMENT_P2_TPL=deployment.yml.part2.tpl
export SERVICE_TPL=service.yml.tpl
export ROUTE_TPL=route.yml.tpl

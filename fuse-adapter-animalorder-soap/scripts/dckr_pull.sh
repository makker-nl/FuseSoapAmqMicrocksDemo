#!/bin/bash
SCRIPTPATH=$(dirname $0)
BASEDIR=$SCRIPTPATH/..
. $SCRIPTPATH/dckr_env.sh
echo Pull image $HOST/$NS/$IMAGE:latest
docker pull $HOST/$NS/$IMAGE:latest

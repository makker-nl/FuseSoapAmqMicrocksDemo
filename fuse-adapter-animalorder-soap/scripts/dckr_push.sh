#!/bin/bash
SCRIPTPATH=$(dirname $0)
BASEDIR=$SCRIPTPATH/..
. $SCRIPTPATH/dckr_env.sh
echo Tag image as $HOST/$NS/$IMAGE:$MVN_VER
docker tag $IMAGE $HOST/$NS/$IMAGE:$MVN_VER
echo push  $HOST/$NS/$IMAGE:$MVN_VER
docker push $HOST/$NS/$IMAGE:$MVN_VER

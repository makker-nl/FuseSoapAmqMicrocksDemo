#!/bin/bash
SCRIPTPATH=$(dirname $0)
BASEDIR=$SCRIPTPATH/..
. $SCRIPTPATH/dckr_env.sh
echo Docker build $IMAGE 
docker build --tag $IMAGE $BASEDIR
echo Tag image $IMAGE as $IMAGE:$MVN_VER
docker tag $IMAGE $IMAGE:$MVN_VER


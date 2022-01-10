#!/bin/bash
SCRIPTPATH=$(dirname $0)
BASEDIR=$SCRIPTPATH/..
CONFDIR=$(readlink -f $BASEDIR/configuration/)
docker run \
  --env-file $CONFDIR/dckr_env.properties \
  --mount type=bind,source=$CONFDIR,target=/configuration \
  -p 8080:8089 \
  fuse-adapter-animalorder-amqp

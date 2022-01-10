#!/bin/bash
SCRIPTPATH=$(dirname $0)
BASEDIR=$SCRIPTPATH/..
docker build --tag fuse-adapter-animalorder-soap $BASEDIR

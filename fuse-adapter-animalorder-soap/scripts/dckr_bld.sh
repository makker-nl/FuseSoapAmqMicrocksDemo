#!/bin/bash
SCRIPTPATH=$(dirname $0)
BASEDIR=$SCRIPTPATH/..
docker build --tag max-adapter-activity-ros $BASEDIR

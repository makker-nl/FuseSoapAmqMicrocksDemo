#!/bin/bash
SCRIPTPATH=$(dirname $0)
BASEDIR=$SCRIPTPATH/..
NS=fuse-microcks-demo
IMAGE=fuse-adapter-animalorder-amqp
HOST=$(oc get route default-route -n openshift-image-registry --template='{{ .spec.host }}')
docker tag $IMAGE $HOST/$NS/$IMAGE
docker push $HOST/$NS/$IMAGE

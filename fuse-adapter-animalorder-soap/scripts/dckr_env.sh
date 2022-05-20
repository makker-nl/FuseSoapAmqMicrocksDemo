#!/bin/bash
SCRIPTPATH=$(dirname $0)
BASEDIR=$SCRIPTPATH/..
export NS=fuse-microcks-demo
export IMAGE=fuse-adapter-animalorder-soap
export MVN_VER=`cd $BASEDIR && mvn org.apache.maven.plugins:maven-help-plugin:2.1.1:evaluate -Dexpression=project.version | sed -n -e '/^\[.*\]/ !{ /^[0-9]/ { p; q } }'`
export HOST=$(oc get route default-route -n openshift-image-registry --template='{{ .spec.host }}')

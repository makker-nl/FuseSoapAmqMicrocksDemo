#!/bin/bash
SCRIPTPATH=$(dirname $0)
CM=keycloak-postconfigure
oc delete cm $CM
oc create cm $CM --from-file $SCRIPTPATH/postconfigure.sh
oc describe cm $CM


#!/bin/bash
#
###################################################################################################
# listKeyStore.sh
# List the certificates in the truststore
#
# author: Martien van den Akker
# (C) november 2021
# VirtualSciences | Conclusion
###################################################################################################
SCRIPTPATH=$(dirname $0)
#
. $SCRIPTPATH/keystore_env.sh
keytool -list -keystore $KEY_STORE -storepass $KEY_PASS -v


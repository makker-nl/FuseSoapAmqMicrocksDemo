#!/bin/bash
#
###################################################################################################
# 0.clean
# Remove keystores en truststores 
#
# author: Martien van den Akker
# (C) April 2022
# VirtualSciences | Conclusion
###################################################################################################
SCRIPTPATH=$(dirname $0)
#
. $SCRIPTPATH/keystore_env.sh
#
echo Remove keystore $KEY_STORE
rm $KEY_STORE
#
echo Remove  truststore $TRUST_STORE
rm $TRUST_STORE
# 
echo Remove  broker keystore $BRKR_KEY_STORE
rm $BRKR_KEY_STORE

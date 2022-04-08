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
BASEDIR=$SCRIPTPATH/../..
BASEDIR_SOAP=$BASEDIR/../fuse-adapter-animalorder-soap
CONFDIR_SOAP=$BASEDIR_SOAP/configuration
TRUST_STORE_SOAP=$CONFDIR_SOAP/truststore.ks
BRKR_KEY_STORE_SOAP=$CONFDIR_SOAP/broker_keystore.ks
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
#
echo Copy SOAP Adapter truststore $TRUST_STORE_SOAP to $TRUST_STORE
cp $TRUST_STORE_SOAP $TRUST_STORE
#
echo Copy SOAP Adapter broker key store $BRKR_KEY_STORE_SOAP to $BRKR_KEY_STORE
cp $BRKR_KEY_STORE_SOAP $BRKR_KEY_STORE

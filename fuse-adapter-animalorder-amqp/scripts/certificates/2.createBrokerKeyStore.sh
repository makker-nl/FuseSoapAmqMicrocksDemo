#!/bin/bash
#
###################################################################################################
# 4.createBrokerKeyStore.sh
# Create a key store for the Broker based on settings in the keystore_env.sh
#
# author: Martien van den Akker
# (C) november 2021
# VirtualSciences | Conclusion
###################################################################################################
SCRIPTPATH=$(dirname $0)
#
. $SCRIPTPATH/keystore_env.sh
echo Create keystore $BRKR_KEY_STORE with key alias $BRKR_KEY_ALIAS, for DName: $BRKR_DNAME
keytool -genkeypair -keyalg RSA -alias $BRKR_KEY_ALIAS  -keypass $BRKR_KEY_PASS -keystore $BRKR_KEY_STORE -storepass $BRKR_KEY_PASS -dname "${BRKR_DNAME}" -validity $VALIDITY -keysize $KEYSIZE -deststoretype pkcs12 -ext SAN=$BRKR_SAN
#
echo Export key alias: $BRKR_KEY_ALIAS from keystore $BRKR_KEY_STORE
keytool -exportcert -keystore $BRKR_KEY_STORE -storepass $BRKR_KEY_PASS -alias $BRKR_KEY_ALIAS -keypass $BRKR_KEY_PASS -file $BRKR_KEY_ALIAS.cer
#
echo Import key alias: $BRKR_KEY_ALIAS into truststore $TRUST_STORE
keytool -importcert -v -trustcacerts -keystore $TRUST_STORE -storepass $TRUST_PASS -file $BRKR_KEY_ALIAS.cer -alias $BRKR_KEY_ALIAS -deststoretype pkcs12 -noprompt

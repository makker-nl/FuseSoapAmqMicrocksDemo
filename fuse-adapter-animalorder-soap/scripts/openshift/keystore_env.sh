#!/bin/bash
#
###################################################################################################
# keystore_env
# Script to set variables to work with keystore/truststores.
#
# author: Martien van den Akker
# (C) januari 2022
# VirtualSciences | Conclusion
###################################################################################################
SCRIPTPATH=$(dirname $0)
if [ -z ${BASEDIR+x} ]; then BASEDIR=$SCRIPTPATH/../.. ; fi
CONFDIR=$BASEDIR/configuration
#
export SOAP_CERT_SECRET_NAME=fuse-adapter-activity-soap-tls-cert
export SOAP_KEY_STORE=$CONFDIR/keystore.ks
export SOAP_KEYSTORE_PWD=Passw0rd
export TRUST_STORE=$CONFDIR/truststore.ks
export TRUSTSTORE_PWD=Passw0rd

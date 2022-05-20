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
SOAP_CONFDIR=$BASEDIR/fuse-adapter-animalorder-soap/configuration
AMQP_CONFDIR=$BASEDIR/fuse-adapter-animalorder-amqp/configuration
#
export SOAP_CERT_SECRET_NAME=fuse-adapter-animalorder-soap-tls-cert
export SOAP_KEY_STORE=$SOAP_CONFDIR/keystore_soap.ks
export SOAP_KEYSTORE_PWD=Passw0rd
export TRUST_STORE=$SOAP_CONFDIR/truststore.ks
export TRUSTSTORE_PWD=Passw0rd
#
export AMQP_USER=mr-miyagi
export AMQP_PASSWORD=jolololokia
export AMQP_USER_SECRET_NAME=fuse-amq-user-secret

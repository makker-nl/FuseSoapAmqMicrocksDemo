#!/bin/bash
#
###################################################################################################
# keystore_env
# Script to set variables to work with keystore/truststores.
#
# author: Martien van den Akker
# (C) September 2021
# VirtualSciences | Conclusion
###################################################################################################
SCRIPTPATH=$(dirname $0)
BASEDIR=$SCRIPTPATH/../..
CONFDIR=$BASEDIR/configuration
#
export KEY_STORE=$CONFDIR/keystore_soap.ks
export KEY_PASS=Passw0rd
export KEY_ALIAS=fuse-adapter-animalorder-soap
export TRUST_STORE=$CONFDIR/truststore.ks
export TRUST_PASS=Passw0rd
export DNAME="CN=${KEY_ALIAS}, OU=RHFuse, O=VS, L=Nieuwegein, ST=UtrechtNL, C=NL, EmailAddress=makker@vs.nl"
export SAN=dns:${KEY_ALIAS},dns:${KEY_ALIAS}.ns.local
export BRKR_KEY_STORE=$CONFDIR/broker_keystore.ks
export BRKR_KEY_PASS=Passw0rd
export BRKR_KEY_ALIAS=fuse-amqp-broker
export BRKR_DNAME="CN=${BRKR_KEY_ALIAS}, OU=RHFuse, O=VS, L=Nieuwegein, ST=UtrechtNL, C=NL, EmailAddress=makker@vs.nl"
export BRKR_SAN=dns:${BRKR_KEY_ALIAS},dns:${BRKR_KEY_ALIAS}.ns.local
export VALIDITY=365
export KEYSIZE=2048

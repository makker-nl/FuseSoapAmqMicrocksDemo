#!/bin/bash
# 
# Consultated web-pages to do the re-configuration.
# http://www.mastertheboss.com/jbossas/jboss-script/advanced-wildfly-cli-variables-and-aliases/
# https://access.redhat.com/solutions/6894911
# https://access.redhat.com/documentation/en-us/red_hat_single_sign-on/7.6/html/server_installation_and_configuration_guide/network#setting_up_ssl
# http://www.mastertheboss.com/jbossas/jboss-security/complete-tutorial-for-configuring-ssl-https-on-wildfly/

export KEYSTORE_PATH=$KEYCLOAK_KEYSTORE_DIR/$KEYCLOAK_KEYSTORE
export TRUSTSTORE_PATH=$KEYCLOAK_TRUSTSTORE_DIR/$KEYCLOAK_TRUSTSTORE

# $JBOSS_HOME/bin/jboss-cli.sh --connect <<EOF
# Start CLI in offline mode.
# Use Embedded server to configure in off-line mode.
# See https://access.redhat.com/documentation/en-us/red_hat_jboss_enterprise_application_platform/7.1/html/management_cli_guide/running_embedded_server

$JBOSS_HOME/bin/jboss-cli.sh <<EOF

  echo Start embedded server: 
  embed-server --std-out=echo --server-config=standalone-openshift.xml  

  echo Reconfigure keystore in ApplicationRalm with: $KEYSTORE_PATH
  /core-service=management/security-realm=ApplicationRealm/server-identity=ssl:write-attribute(name=keystore-path, value=$KEYSTORE_PATH)
  /core-service=management/security-realm=ApplicationRealm/server-identity=ssl:write-attribute(name=keystore-password, value=$KEYCLOAK_KEYSTORE_PASSWORD)
  
  echo Reconfigure truststore in Keycloak server with: $TRUSTSTORE_PATH
  /subsystem=keycloak-server/spi=truststore/provider=file:write-attribute(name=properties, value={"file" => "$TRUSTSTORE_PATH","password" => "$KEYCLOAK_TRUSTSTORE_PASSWORD","hostname-verification-policy" => "WILDCARD","disabled" => "false"})

  stop-embedded-server

  exit

EOF

kind: Secret
apiVersion: v1
metadata:
  name: ${CERT_SECRET_NAME}
  namespace: ${NS}
data:
  keyStorePassword: ${KEYSTORE_PWD_B64}
  keystore.ks: >-
    ${KEYSTORE_B64}
  trustStorePassword: ${TRUSTSTORE_PWD_B64}
  truststore.ts: >-
    ${TRUSTSTORE_B64}
type: Opaque


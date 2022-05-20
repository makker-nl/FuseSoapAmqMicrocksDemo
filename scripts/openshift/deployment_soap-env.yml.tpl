          env:
            - name: AMQP_REMOTEURI
              value: '${AMQP_REMOTEURI}'
            - name: AMQP_SERVICE_ADDRESS
              value: '${AMQP_SERVICE_ADDRESS}'
            - name: AMQP_USERNAME
              value: ${AMQP_USER}
            - name: LOGGING_LEVEL_NL_VS_FUSE_DEMO
              value: DEBUG
            - name: SERVER_PORT
              value: '${SERVICE_PORT}'
            - name: SERVER_SSL_CLIENT-AUTH
              value: none
            - name: SERVER_SSL_ENABLED
              value: 'true'
            - name: AMQP_PASSWORD
              valueFrom:
                secretKeyRef:
                  name: ${AMQP_USER_SECRET_NAME}
                  key: password
            - name: KEYSTORE
              value: /etc/keystore-cert/keystore.ks
            - name: KEYSTORE_PASSWORD
              valueFrom:
                secretKeyRef:
                  name: ${CERT_SECRET_NAME}
                  key: keyStorePassword
            - name: TRUSTSTORE
              value: /etc/keystore-cert/truststore.ts
            - name: TRUSTSTORE_PASSWORD
              valueFrom:
                secretKeyRef:
                  name: ${CERT_SECRET_NAME}
                  key: trustStorePassword

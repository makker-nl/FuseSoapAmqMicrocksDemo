          volumeMounts:
            - name: keystore-cert
              readOnly: true
              mountPath: /etc/keystore-cert/
          terminationMessagePath: /dev/termination-log
          terminationMessagePolicy: File
      restartPolicy: Always
      terminationGracePeriodSeconds: 30
      dnsPolicy: ClusterFirst
      securityContext: {}
      schedulerName: default-scheduler
      volumes:
        - name: keystore-cert
          secret:
            secretName: ${CERT_SECRET_NAME}
            defaultMode: 420
  strategy:
    type: RollingUpdate
    rollingUpdate:
      maxUnavailable: 25%
      maxSurge: 25%
  revisionHistoryLimit: 10
  progressDeadlineSeconds: 600

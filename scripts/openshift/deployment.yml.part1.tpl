kind: Deployment
apiVersion: apps/v1
metadata:
  name: ${DEPL_NAME}
  namespace: ${NS}
  labels:
    app: ${APP_NAME}
spec:
  replicas: 1
  selector:
    matchLabels:
      deployment: ${DEPL_NAME}
  template:
    metadata:
      labels:
        deployment: ${DEPL_NAME}
    spec:
      containers:     
        - name: ${APP_NAME}
          image: >-
            ${IMG_REG_URL}/${NS}/${APP_NAME}:${APP_VERSION}
          imagePullPolicy: Always
          resources:
            limits:
              cpu: 500m
              memory: 1Gi
            requests:
              cpu: 500m
              memory: 512Mi
          readinessProbe:
            httpGet:
              path: /actuator/health
              port: 8081
              scheme: HTTP
            timeoutSeconds: 1
            periodSeconds: 10
            successThreshold: 1
            failureThreshold: 3
          livenessProbe:
            httpGet:
              path: /actuator/health
              port: 8081
              scheme: HTTP
            timeoutSeconds: 1
            periodSeconds: 10
            successThreshold: 1
            failureThreshold: 3
          startupProbe:
            httpGet:
              path: /actuator/health
              port: 8081
              scheme: HTTP
            initialDelaySeconds: 10
            timeoutSeconds: 1
            periodSeconds: 10
            successThreshold: 1
            failureThreshold: 30
          ports:
            - name: metrics
              containerPort: 8081
              protocol: TCP
            - name: https-ros
              containerPort: 8443
              protocol: TCP

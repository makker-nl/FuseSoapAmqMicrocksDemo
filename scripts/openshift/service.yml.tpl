apiVersion: v1
kind: Service
metadata:
  name: ${SERVICE_NAME}     
  namespace: ${NS}
spec:
  selector:                  
    deployment: ${DEPL_NAME}   
  ports:
  - name: ${SERVICE_PORT_NAME}
    port: ${SERVICE_PORT}
    protocol: TCP
    targetPort: ${SERVICE_TARGET_PORT}

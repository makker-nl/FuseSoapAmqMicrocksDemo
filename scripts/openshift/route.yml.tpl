kind: Route
apiVersion: route.openshift.io/v1
metadata:
  name: ${ROUTE_NAME}     
  namespace: ${NS}
spec:
  to:
    kind: Service
    name: ${SERVICE_NAME}
    weight: 100
  port:
    targetPort: ${SERVICE_PORT_NAME}
  tls:
    termination: passthrough
    insecureEdgeTerminationPolicy: None
  wildcardPolicy: None

kind: Secret
apiVersion: v1
metadata:
  name: ${USER_SECRET_NAME}
  namespace: ${NS}
data:
  password: ${PASSWORD_B64}
  username: ${USER_B64}
type: Opaque


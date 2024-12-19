# Used for storing basic auth credentials (username and password).

* **Example:**
* Create a basic auth Secret using a manifest file.

* `basic-auth-secret.yaml`
```bash
apiVersion: v1
kind: Secret
metadata:
  name: my-basic-auth-secret
type: kubernetes.io/basic-auth
data:
  username: dXNlcm5hbWU=    # base64 encoded 'username'
  password: cGFzc3dvcmQ=    # base64 encoded 'password'
```

* To create via command line:
```bash
kubectl create secret generic my-basic-auth-secret --type=kubernetes.io/basic-auth --from-literal=username='username' --from-literal=password='password'
```

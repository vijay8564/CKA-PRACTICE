# 1. Opaque Secrets
* The default and most common type of Secret. These are arbitrary key-value pairs.

* Example:
**Create an Opaque Secret using a manifest file.**
```bash
apiVersion: v1
kind: Secret
metadata:
  name: my-opaque-secret
type: Opaque
data:
  username: dXNlcm5hbWU=    # base64 encoded string for 'username'
  password: cGFzc3dvcmQ=    # base64 encoded string for 'password'
```
* To create the Secret:
```bash
kubectl apply -f opaque-secret.yaml
```

* To create it via the command line:
```bash
kubectl create secret generic opaque-secret --type=Opaque --from-literal username'=vijay' --from-literal password='password'
```

## 1. Mount Secret as a Volume
* **Pod YAML with Secret as a Volume**
* You can mount the Secret into a Pod using a volume.
```bash
apiVersion: v1
kind: Pod
metadata:
  name: secret-volume-pod
spec:
  containers:
  - image: nginx
    name: secret-volume-pod
    volumeMounts:
      - name: secret-volume
        mountPath: "/etc/secret"
        readOnly: true
  volumes:
    - name: secret-volume
      secret:
        secretName: opaque-secret
```

* **Accessing Secret in the Container**
*Once mounted, the Secret's data will be available as files inside the /etc/secret directory:

/etc/secret/username
/etc/secret/password

## 2. Use Secret as Environment Variables
* You can also pass Secret values as environment variables.

* **Pod YAML with Secret as Environment Variables**
```bash
apiVersion: v1
kind: Pod
metadata:
  name: secret-env-pod
spec:
  containers:
    - name: my-container
      image: nginx
      env:
        - name: SECRET_USERNAME
          valueFrom:
            secretKeyRef:
              name: opaque-secret
              key: username
        - name: SECRET_PASSWORD
          valueFrom:
            secretKeyRef:
              name: opaque-secret
              key: password
```
* Accessing Environment Variables
*Inside the container, the environment variables SECRET_USERNAME and SECRET_PASSWORD will be set with the corresponding Secret values.


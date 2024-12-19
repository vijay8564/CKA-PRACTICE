# 2. Docker Registry Secrets
* Used to store credentials for accessing private Docker registries.

* **Example:**
* Create a Docker registry Secret using the command line.
```bash
kubectl create secret docker-registry my-docker-secret \
--docker-server=docker.io \
--docker-username=<username> \
--docker-password=<mypassword> \
--docker-email=<myemail@example.com>
--namespace=<namespace-name>
```
* **Manifest file example:**
* `docker-secret.yaml`
```bash
apiVersion: v1
kind: Secret
metadata:
  name: my-docker-secret
type: kubernetes.io/dockerconfigjson
data:
  .dockerconfigjson: eyJhdXRocyI6eyJyZWdpc3RyeS5leGFtcGxlLmNvbSI6eyJ1c2VybmFtZSI6Im15dXNlciIsInBhc3N3b3JkIjoibXlwYXNzd29yZCIsImVtYWlsIjoibXllbWFpbEBleGFtcGxlLmNvbSJ9fX0=
```
*  **Encode Using Command Line**
```bash
echo '{
  "auths": {
    "registry.example.com": {
      "username": "myuser",
      "password": "mypassword",
      "email": "myemail@example.com"
    }
  }
}' > config.json | base64 -w 0 config.json
```
* Output:
```bash
ewogICJhdXRocyI6IHsKICAgICJyZWdpc3RyeS5leGFtcGxlLmNvbSI6IHsKICAgICAgInVzZXJuYW1lIjogIm15dXNlciIsCiAgICAgICJwYXNzd29yZCI6ICJteXBhc3N3b3JkIiwKICAgICAgImVtYWlsIjogIm15ZW1haWxAZXhhbXBsZS5jb20iCiAgICB9CiAgfQp9Cg==
```
* **How to Use the Secret in a Pod**
* You can use this Secret to pull images from the private Docker registry in your Pod specification:

```bash
apiVersion: v1
kind: Pod
metadata:
  name: private-registry-pod
spec:
  containers:
    - name: my-container
      image: registry.example.com/my-app:latest
  imagePullSecrets:
    - name: my-docker-secret
```
** imagePullSecrets: References the Secret my-docker-secret to pull the image from the private registry.**

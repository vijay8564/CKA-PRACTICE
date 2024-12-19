 # SSH Authentication Secrets
* Used for storing SSH private keys.

* **Example:**
* `ssh-secret.yaml`
```bash
apiVersion: v1
kind: Secret
metadata:
  name: my-ssh-secret
type: kubernetes.io/ssh-auth
data:
  ssh-privatekey: base64-encoded-private-key
```

* To create via command line:
```bash
kubectl create secret generic my-ssh-secret --type=kubernetes.io/ssh-auth --from-file=ssh-privatekey=path/to/id_rsa
```

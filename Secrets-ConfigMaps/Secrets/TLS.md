# 3. TLS Secrets
* Used for storing TLS certificates and keys for securing communication.

* **Example:**
* Create a TLS Secret using a manifest file.

* `tls-secret.yaml`
```bash
apiVersion: v1
kind: Secret
metadata:
  name: my-tls-secret
type: kubernetes.io/tls
data:
  tls.crt: base64-encoded-cert
  tls.key: base64-encoded-key
```
* To create the Secret via command line:

```bash
kubectl create secret tls my-tls-secret --cert=path/to/cert.crt --key=path/to/key.key
```

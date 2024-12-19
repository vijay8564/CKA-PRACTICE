# Kubernetes automatically creates these Secrets to hold tokens for ServiceAccounts. These tokens can be mounted into Pods for authenticating with the API server.

* **Example:**
* Manually create a ServiceAccount token Secret.

* `sa-token-secret.yaml`
```bash
apiVersion: v1
kind: Secret
metadata:
  name: my-sa-token
  annotations:
    kubernetes.io/service-account.name: my-service-account
type: kubernetes.io/service-account-token
```

* `To apply:`
```bash
kubectl apply -f sa-token-secret.yaml
```

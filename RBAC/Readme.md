# 🚀 Understanding Kubernetes RBAC and Creating Users with OpenSSL 🚀

* Role-Based Access Control (RBAC) in Kubernetes is essential for securely managing who can access what within a cluster.
*  Here’s a simplified breakdown of how to create a new Kubernetes user with OpenSSL and assign permissions using RBAC!

## 1️⃣ Creating a Kubernetes User with OpenSSL 🔐
* We can generate a certificate signing request (CSR) and sign it with the Kubernetes CA to create a new user.

* 1. **Generate a private key:**
```bash
openssl genrsa -out pod-reader.key 2048
```
* 2. **Create a CSR (Certificate Signing Request)::**
```bash
openssl req -new -key pod-reader.key -out pod-reader.csr -subj "/CN=pod-reader"
```
* 3. **Sign the CSR with the Kubernetes CA:**
```bash
sudo openssl x509 -req -in pod-reader.csr -CA /etc/kubernetes/pki/ca.crt -CAkey /etc/kubernetes/pki/ca.key -CAcreateserial -out pod-reader.crt -days 365
```
* 4. **Configure kubectl to use the new user:**
```bash
kubectl config set-credentials pod-reader --client-certificate=pod-reader.crt --client-key=pod-reader.key
```

## 2️⃣ Creating a Role and RoleBinding for Namespace Access 🛠️
* Grant the pod-reader user permissions to list and get pods within a specific namespace.
* 1. **Create a Role:**
```bash
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  namespace: default
  name: pod-reader
rules:
  - apiGroups: [""]
    resources: ["pods"]
    verbs: ["get", "list"]
```

* 2. **Create a RoleBinding:**
```bash
apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
  name: pod-reader-binding
  namespace: default
subjects:
  - kind: User
    name: pod-reader
    apiGroup: rbac.authorization.k8s.io
roleRef:
  kind: Role
  name: pod-reader
  apiGroup: rbac.authorization.k8s.io
```
* 3. **Apply the Role and RoleBinding:**
```bash
kubectl apply -f pod-reader-role.yaml
kubectl apply -f pod-reader-rolebinding.yaml
```
## 3️⃣ Creating a ClusterRole and ClusterRoleBinding for Cluster-Wide Access 🌐
* To grant cluster-wide pod access to pod-reader:
* 1. **Create a ClusterRole:**
```bash
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
  name: cluster-pod-reader
rules:
  - apiGroups: [""]
    resources: ["pods"]
    verbs: ["get", "list"]
```
* 2. **Create a ClusterRoleBinding:**
```bash
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRoleBinding
metadata:
  name: cluster-pod-reader-binding
subjects:
  - kind: User
    name: pod-reader
    apiGroup: rbac.authorization.k8s.io
roleRef:
  kind: ClusterRole
  name: cluster-pod-reader
  apiGroup: rbac.authorization.k8s.io
```
* 3. **Apply the ClusterRole and ClusterRoleBinding:**
```bash
kubectl apply -f cluster-pod-reader-role.yaml
kubectl apply -f cluster-pod-reader-rolebinding.yaml
```

## Use contexts:
```bash
# view current context and all contexts
kubectl config current-context
kubectl config get-contexts
# view all users
kubectl config get-users
# view cluster name
kubectl config get-clusters
# set pod-reader context
kubectl config set-context pod-reader --cluster=kubernetes --user=pod-reader
# use pod-readercontext
kubectl config use-context pod-reader
# set cluster-pod-reader
kubectl config set-context cluster-pod-reader --cluster=kubernetes --user=cluster-pod-reader
#use cluster-pod-reader context
kubectl config use-context cluster-pod-reader
```
# 🔎 Summary
* With RBAC in Kubernetes, we can precisely manage access to resources:

**Roles/RoleBindings for namespace-specific permissions.**
**ClusterRoles/ClusterRoleBindings for cluster-wide permissions.**
* This ensures secure and granular control over who can access your cluster resources. 🛡️





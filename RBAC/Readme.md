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


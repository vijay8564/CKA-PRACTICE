# 🚀 Understanding Kubernetes RBAC and Creating Users with OpenSSL 🚀

* Role-Based Access Control (RBAC) in Kubernetes is essential for securely managing who can access what within a cluster.
*  Here’s a simplified breakdown of how to create a new Kubernetes user with OpenSSL and assign permissions using RBAC!

## 1️⃣ Creating a Kubernetes User with OpenSSL 🔐
* We can generate a certificate signing request (CSR) and sign it with the Kubernetes CA to create a new user.

* 1.Generate a private key:

# 🧠 What is etcd in Kubernetes? 🔍
* `etcd` is a `distributed key-value` store used by Kubernetes to store and manage the cluster's state and configuration data.
*  It is a core component of the Kubernetes control plane.
## 🔹 Key Features of etcd:
* 1. **Highly Available:**
* Designed to run as a distributed system across multiple nodes to ensure high availability.
* Uses the Raft consensus algorithm to achieve fault tolerance and data consistency.

* 2. **Strong Consistency:**
* Guarantees that reads and writes are consistent across the cluster, even if nodes fail.

* 3. **Key-Value Storage:**
* Stores data in a simple key-value format, making it easy to retrieve and update configuration and state data.

* 4. **Secure:**
*Supports encryption, authentication, and TLS for secure communication.


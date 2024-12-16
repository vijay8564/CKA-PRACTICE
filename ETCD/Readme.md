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

## 🔹 Why is etcd Important in Kubernetes?
* In Kubernetes, etcd serves as the "single source of truth" for the cluster. It stores:

    * `Cluster State`: Nodes, pods, services, deployments, configurations.
    * `Secrets and ConfigMaps`: Sensitive information and application settings.
    * `Resource Quotas and Policies`: Limits and rules for cluster operations.
* If etcd fails or becomes corrupted, the Kubernetes cluster cannot function properly because the control plane relies on it for all operations.

## 🔹 How Kubernetes Uses etcd:

* `kube-apiserver` reads from and writes to etcd to handle cluster requests.
* `kube-controller-manager` watches etcd for changes and maintains the desired state of the cluster.
* `kube-scheduler` reads from etcd to determine where to schedule pods.

## 🔹 Key Operations with etcd:
* `Backup`: To protect your cluster's state.
* `Restore`: To recover from failures.
* `Scaling`: Deploy etcd as a multi-node cluster for high availability.

## 🔹 Commands to Interact with etcd:
* install `etcdctl` command line tool.
```bash
sudo apt  install etcd-client
```
* Export etcd variables
```bash
export ETCDCTL_API=3
export ETCDCTL_ENDPOINTS="https://127.0.0.1:2379"
export ETCDCTL_CACERT="/etc/kubernetes/pki/etcd/ca.crt"
export ETCDCTL_CERT="/etc/kubernetes/pki/etcd/server.crt"
export ETCDCTL_KEY="/etc/kubernetes/pki/etcd/server.key"
```
* create nginx deployment
```bash
kubectl create deployment nginx --image nginx --replicas 4
kubectl get po
```
* Take etcd snapshot
```bash
etcdctl snapshot save backup.db
```
* Check status of snapshot
```bash
etcdctl snapshot status backup.db
```
* Delete the deployment
```bash
kubectl delete deploy nginx
```
* Stop etcd Pod
```bash
sudo mv /etc/kubernetes/manifests/etcd.yaml /etc/kubernetes/manifests/etcd.yaml.bak
```
* Restore the etcd Data
```bash
sudo etcdctl snapshot restore backup.db --data-dir /var/lib/etcd-new
```
* Replace the Existing Data Directory
```bash
sudo mv /var/lib/etcd /var/lib/etcd.bak
sudo mv /var/lib/etcd-new /var/lib/etcd
```
* Restart the etcd Pod
```bash
sudo mv /etc/kubernetes/manifests/etcd.yaml.bak /etc/kubernetes/manifests/etcd.yaml
```
* Verify the deleted deployment restored or not
```bash
kubectl get po
```
 



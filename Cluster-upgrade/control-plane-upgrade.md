# Upgrading kubeadm clusters
## Upgrade a control plane node
* **Changing the package repository**
```bash
sudo cat /etc/apt/sources.list.d/kubernetes.list
# deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.31/deb/ /
# Change the version in the URL to the next available minor release, for example v1.32
sudo sed -i 's/v1\.30/v1\.31/g' /etc/apt/sources.list.d/kubernetes.list
sudo cat /etc/apt/sources.list.d/kubernetes.list
# deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.32/deb/ /
```
* **Determine which version to upgrade to**
```bash
# Find the latest 1.32 version in the list.
# It should look like 1.32.x-*, where x is the latest patch.
sudo apt update
sudo apt-cache madison kubeadm
```
### Call "kubeadm upgrade"**
* **kubeadm upgrade**
```bash
# replace x in 1.32.x-* with the latest patch version
sudo apt-mark unhold kubeadm && \
sudo apt-get update && sudo apt-get install -y kubeadm='1.32.x-*' && \
sudo apt-mark hold kubeadm
```
  * **Verify that the download works and has the expected version**
  ```bash
  kubeadm version
  ```
* **Verify the upgrade plan**
```bash
sudo kubeadm upgrade plan
```
* **Choose a version to upgrade to, and run the appropriate command**
```bash
# replace x with the patch version you picked for this upgrade
sudo kubeadm upgrade apply v1.32.x
```
* **Drain the node**
```bash
# replace <node-to-drain> with the name of your node you are draining
kubectl drain <node-to-drain> --ignore-daemonsets
```
### Upgrade kubelet and kubectl

* **Upgrade the kubelet and kubectl**
```bash
sudo apt-mark unhold kubelet kubectl && \
sudo apt-get update && sudo apt-get install -y kubelet='1.32.x-*' kubectl='1.32.x-*' && \
sudo apt-mark hold kubelet kubectl
```
* **Restart the kubelet**
```bash
sudo systemctl daemon-reload
sudo systemctl restart kubelet
```
* **Uncordon the node**
```bash
kubectl uncordon <node-to-uncordon>
```
* **Verify the status of the cluster**
```bash
kubectl get nodes
```

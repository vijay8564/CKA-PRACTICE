# Upgrading kubeadm clusters
## Upgrade a primary control plane node
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
* **Upgrading control plane nodes**
``bash
# replace x in 1.32.x-* with the latest patch version
sudo apt-mark unhold kubeadm && \
sudo apt-get update && sudo apt-get install -y kubeadm='1.32.x-*' && \
sudo apt-mark hold kubeadm
```
  * Verify that the download works and has the expected version
  ```bash
  kubeadm version
  ```

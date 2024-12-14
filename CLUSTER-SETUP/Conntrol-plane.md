# 🚀 Setting up a Kubernetes Cluster with Kubeadm and Deploying Calico with Helm 🚀

* I recently set up a Kubernetes cluster using `kubeadm` and deployed **Calico** as the network plugin via **Helm**. Here’s a quick guide for anyone interested in doing the same:
## 🔧 Step-by-step Process:
### 1. **Containerd (Container Runtime)**  
* Start by installing and configuring `containerd` as the container runtime for Kubernetes.

```bash
sudo apt-get update
sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install -y containerd.io
sudo mkdir -p /etc/containerd
sudo containerd config default | sudo tee /etc/containerd/config.toml
sudo sed -i 's/SystemdCgroup = false/SystemdCgroup = true/' /etc/containerd/config.toml
sudo systemctl restart containerd
sudo systemctl enable containerd
sudo systemctl daemon-reload
sudo systemctl status containerd
```
### 2. **Install Kubernetes Components**
* Add the Kubernetes apt repository and install `kubelet`, `kubeadm`, and `kubectl`:

```bash
sudo apt-get update
sudo apt-get install -y apt-transport-https ca-certificates curl gpg
curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.30/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.30/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list
sudo apt-get update
sudo apt-get install -y kubelet kubeadm kubectl
sudo apt-mark hold kubelet kubeadm kubectl
```
### 3. ** Enable IP Forwarding**
* Enable IPv4 forwarding to ensure proper network communication for the Kubernetes pods:
```bash
sudo sysctl -w net.ipv4.ip_forward=1
```
### 4. **Initialize Kubernetes Cluster**
* Use `kubeadm init` to initialize the Kubernetes master node. Be sure to set the `--pod-network-cidr` for Calico networking:
```bash
sudo kubeadm init --pod-network-cidr "10.244.0.0/16" --cri-socket "unix:///var/run/containerd/containerd.sock"
```
### 5. **Configure kubectl for Your User**
* Set up the Kubernetes configuration file to allow seamless interaction with the cluster:
```bash
mkdir -p $HOME/.kube/
sudo cp /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $USER:$USER $HOME/.kube/config
```
### 6. **Install Helm**
If Helm is not installed, install it using the following command:
```bash
sudo snap install helm --classic
```
### 7. **Deploy Calico Using Helm**
* Add the Calico Helm repository:
```bash
  helm repo add projectcalico https://docs.tigera.io/calico/charts
```
* Create the tigera-operator namespace:
```bash
kubectl create namespace tigera-operator
```
* Install the Calico operator in the tigera-operator namespace:
```bash
helm install calico projectcalico/tigera-operator --version v3.29.1 --namespace tigera-operator
```
### 8. **Verify the Installation**
* Use `kubectl` to check the status of the Calico pods and all pods:

```bash
kubectl get pods -n calico-system
kubectl get po -A
```
### 9. ** Cluster-setup by cloning this repo**
* Execute the below commands:
```bash
git clone https://github.com/vijay8564/CKA-PRACTICE.git
cd CKA-PRACTICE/CLUSTER-SETUP
sudo chmod +x cluster-setup.sh
./cluster-setup.sh
```
# Why Calico?
*Calico provides powerful networking features for Kubernetes clusters, including NetworkPolicy enforcement, IP address management, and high-performance networking.

*This setup ensures a robust Kubernetes environment with scalable and secure networking.

*It's a great starting point for anyone looking to get hands-on experience with Kubernetes networking.

*Feel free to reach out if you need any help with the process or have any questions!

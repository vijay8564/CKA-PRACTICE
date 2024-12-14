# 🚀 Setting up a Kubernetes Cluster with Kubeadm and Deploying Calico with Helm 🚀

I recently set up a Kubernetes cluster using `kubeadm` and deployed **Calico** as the network plugin via **Helm**. Here’s a quick guide for anyone interested in doing the same:
## 🔧 Step-by-step Process:
### 1. **Containerd (Container Runtime)**  
Start by installing and configuring `containerd` as the container runtime for Kubernetes.

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

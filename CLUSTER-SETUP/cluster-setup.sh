#!/bin/bash
sudo apt-get update > /dev/null
sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update > /dev/null
sudo apt-get install -y containerd.io > /dev/null
sudo mkdir -p /etc/containerd
sudo containerd config default | sudo tee /etc/containerd/config.toml
sudo sed -i 's/SystemdCgroup = false/SystemdCgroup = true/' /etc/containerd/config.toml
sudo systemctl restart containerd
sudo systemctl enable containerd
sudo systemctl daemon-reload
sudo apt-get update > /dev/null
sudo apt-get install -y apt-transport-https ca-certificates curl gpg > /dev/null
curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.30/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg > /dev/null
echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.30/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list
sudo apt-get update > /dev/null
sudo apt-get install -y kubelet kubeadm kubectl > /dev/null
sudo apt-mark hold kubelet kubeadm kubectl
sudo sysctl -w net.ipv4.ip_forward=1
sudo kubeadm init --pod-network-cidr "10.244.0.0/16" --cri-socket "unix:///var/run/containerd/containerd.sock" > /dev/null
mkdir -p $HOME/.kube/
sudo cp /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $USER:$USER $HOME/.kube/config
sudo snap install helm --classic > /dev/null
helm repo add projectcalico https://docs.tigera.io/calico/charts
kubectl create namespace tigera-operator
helm install calico projectcalico/tigera-operator --version v3.29.1 --namespace tigera-operator > /dev/null
kubectl get pods -n calico-system
kubeadm token create --print-join-command

#!/bin/bash

for user in pod-creator-role pod-creator-cluster-role; do
  # Generate private key and CSR
  openssl genrsa -out ${user}.key 2048
  openssl req -new -key ${user}.key -out ${user}.csr -subj "/CN=${user}"
  
  # Sign the CSR with the Kubernetes CA
  sudo openssl x509 -req -in ${user}.csr -CA /etc/kubernetes/pki/ca.crt -CAkey /etc/kubernetes/pki/ca.key -CAcreateserial -out ${user}.crt -days 365
  
  # Set user credentials in kubectl
  kubectl config set-credentials ${user} --client-certificate=${user}.crt --client-key=${user}.key

  # Create ClusterRole if it doesn't exist
  if ! kubectl get clusterrole ${user} &>/dev/null; then
    kubectl create clusterrole pod-creator-cluster-role --verb=get,list,watch,create,update --resource=pods
  else
    echo "ClusterRole 'pod-creator-cluster-role' already exists."
  fi

  # Create ClusterRoleBinding if it doesn't exist
  if ! kubectl get clusterrolebinding ${user} &>/dev/null; then
    kubectl create clusterrolebinding pod-creator-cluster-role --clusterrole=pod-creator-cluster-role --user=pod-creator-cluster-role
  else
    echo "ClusterRoleBinding 'pod-creator-cluster-role' already exists."
  fi

  # Create Role if it doesn't exist
  if ! kubectl get role ${user} -n default &>/dev/null; then
    kubectl create role pod-creator-role --verb=get,list,watch,create,update --resource=pods --namespace=default
  else
    echo "Role 'pod-creator-role' already exists."
  fi

  # Create RoleBinding if it doesn't exist
  if ! kubectl get rolebinding ${user} -n default &>/dev/null; then
    kubectl create rolebinding pod-creator-role --role=pod-creator-role --user=pod-creator-role --namespace=default
  else
    echo "RoleBinding 'pod-creator-role' already exists."
  fi

  # Set context for the user
  kubectl config set-context ${user} --cluster=kubernetes --user=${user}
done

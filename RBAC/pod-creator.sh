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
  if ! kubectl get clusterrole ${user}-cluster-role &>/dev/null; then
    kubectl create clusterrole ${user}-cluster-role --verb=get,list,watch,create,update --resource=pods
  else
    echo "ClusterRole '${user}-cluster-role' already exists."
  fi

  # Create ClusterRoleBinding if it doesn't exist
  if ! kubectl get clusterrolebinding ${user}-cluster-role-binding &>/dev/null; then
    kubectl create clusterrolebinding ${user}-cluster-role-binding --clusterrole=${user}-cluster-role --user=${user}
  else
    echo "ClusterRoleBinding '${user}-cluster-role-binding' already exists."
  fi

  # Create Role if it doesn't exist
  if ! kubectl get role ${user}-role -n default &>/dev/null; then
    kubectl create role ${user}-role --verb=get,list,watch,create,update --resource=pods --namespace=default
  else
    echo "Role '${user}-role' already exists."
  fi

  # Create RoleBinding if it doesn't exist
  if ! kubectl get rolebinding ${user}-role-binding -n default &>/dev/null; then
    kubectl create rolebinding ${user}-role-binding --role=${user}-role --user=${user} --namespace=default
  else
    echo "RoleBinding '${user}-role-binding' already exists."
  fi

  # Set context for the user
  kubectl config set-context ${user} --cluster=kubernetes --user=${user}
done

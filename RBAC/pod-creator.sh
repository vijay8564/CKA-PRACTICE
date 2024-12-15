#!/bin/bash
for user in pod-creator-role pod-creator-cluster-role; do
  openssl genrsa -out ${user}.key 2048
  openssl req -new -key ${user}.key -out ${user}.csr -subj "/CN=${user}"
  sudo openssl x509 -req -in ${user}.csr -CA /etc/kubernetes/pki/ca.crt -CAkey /etc/kubernetes/pki/ca.key -CAcreateserial -out ${user}.crt -days 365
  kubectl config set-credentials ${user} --client-certificate=${user}.crt --client-key=${user}.key
  kubectl create clusterrole pod-creator-cluster-role --verb=get,list,watch,create,update --resource=pods
  kubectl create clusterrolebinding pod-creator-cluster-role --clusterrole=pod-creator-cluster-role --user=pod-creator-cluster-role
  kubectl create role pod-creator-role --verb=get,list,watch,create,update --resource=pods --namespace=default
  kubectl create rolebinding pod-creator-role --role=pod-creator-role --user=pod-creator-role
  kubectl config set-context ${user} --cluster=kubernetes --user=${user}
done

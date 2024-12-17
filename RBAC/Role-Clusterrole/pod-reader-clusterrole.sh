#!/bin/bash
sudo openssl genrsa -out cluster-pod-reader.key 2048
sudo openssl req -new -key cluster-pod-reader.key -out cluster-pod-reader.csr -subj "/CN=cluster-pod-reader"
sudo openssl x509 -req -in cluster-pod-reader.csr -CA /etc/kubernetes/pki/ca.crt -CAkey /etc/kubernetes/pki/ca.key -CAcreateserial -out cluster-pod-reader.crt -days 365

kubectl config set-credentials cluster-pod-reader --client-certificate=cluster-pod-reader.crt --client-key=cluster-pod-reader.key
kubectl config get-users
kubectl config set-context cluster-pod-reader --cluster=kubernetes --user=cluster-pod-reader
kubectl config get-contexts
kubectl create clusterrole cluster-pod-reader --verb=get,list,watch --resource=pods
kubectl create clusterrolebinding cluster-pod-reader --clusterrole=cluster-pod-reader --user=cluster-pod-reader
kubectl config use-context cluster-pod-reader
# you can't create or run pods
# you can only get list watch pods across the cluster

# Running Pods with Least Privilege (RBAC)
* Goal: Ensure workloads only have the permissions they need.
* Example: Grant a pod read-only access to pods.

## create a kubectl pod to get the pods in a cluster
* run pod
```bash
kubectl run pod1 --image bitnami/kubectl --comannd sleep "3600s"
```
* ssh into pod
```bash
kubectl exec -it pod1 /bin/sh
```
* get pods
```bash
kubectl get pods
```
* output
```bash
Error from server (Forbidden): pods is forbidden: User "system:serviceaccount:default:default" cannot list resource "pods" in API group "" in the namespace "default"
```

## create a kubectl pod with pod-reader sa,role,rolebinding
* create serviceAccount
```bash
kubectl create serviceaccount pod-reader
```
  
* create role
```bash
kubectl  create role pod-reader --verb=get,list,watch --resource=pods
```
* create rolebinding (namespaced resource)
```bash
kubectl create rolebinding pod-reader-rolebinding --role=pod-reader --serviceaccount=default:pod-reader --namespace=default
```
* create pod with sa pod-reader
```bash
kubectl run pod2 --image bitnami/kubectl --command sleep "3600s" --dry-run=client -o yaml > pod2.yaml
vi pod2.yaml
#add serviceAccountName: pod-reader in spec
kubectl apply -f pod2.yaml
```
* ssh into pod
```bash
kubectl exec -it pod2 /bin/sh
```
* output
```bash
$kubectl get po
NAME   READY   STATUS    RESTARTS       AGE
pod1   1/1     Running   1 (3m8s ago)   63m
pod2   1/1     Running   0              49m
pod3   1/1     Running   0              21m
```
* cross check the permissions with delete pod pod1 
```bash
kubectl delete pod pod1 
```
* output
```bash
Error from server (Forbidden): pods "pod1" is forbidden: User "system:serviceaccount:default:pod-reader" cannot delete resource "pods" in API group "" in the namespace "default"
```

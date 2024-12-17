# Demonstrate image pull secrests with service accounts

## create a pod using docker private registry image
* run pod
```bash
kubectl run my-private-image-pod1 --image vijaydevops2012/ss:1.0.0
```
* List pods
```bash
kubectl get pods
```
* check pod events
```bash
kubectl events pod
```
* output
```bash
10m (x4 over 12m)       Normal    Pulling     Pod/my-private-image-pod    Pulling image "vijaydevops2012/ss:1.0.0"
10m (x4 over 12m)       Warning   Failed      Pod/my-private-image-pod    Failed to pull image "vijaydevops2012/ss:1.0.0": failed to pull and unpack image "docker.io/vijaydevops2012/ss:1.0.0": failed to resolve reference "docker.io/vijaydevops2012/ss:1.0.0": pull access denied, repository does not exist or may require authorization: server message: insufficient_scope: authorization failed
10m (x4 over 12m)       Warning   Failed      Pod/my-private-image-pod    Error: ErrImagePull
10m (x6 over 12m)       Warning   Failed      Pod/my-private-image-pod    Error: ImagePullBackOff
```
* it means docker registry credentials are not configured

## create a pod using docker private registry image with docker registry configured

* create docker registry credentials secret
```bash
kubectl create secret docker-registry docker-cred --docker-server=docker.io\
--docker-username=vijaydevops2012 \
--docker-password=<docker-hub-password> or <PAT> \
--docker-email=vijaykumarmekala8564@gmail.com \
--namespace=default
```
* create service account
```bash
kubectl create serviceaccount docker-cred-sa --namespace=default
```
* path sa with secret
```bash
kubectl patch serviceaccount docker-cred-sa -p "{\"imagePullSecrets\": [{\"name\": \"docker-cred\"}]}" --namespace=default
```
* run pod2 with redirect the values into yaml
```bash
kubectl run my-private-image-pod2 --image vijaydevops2012/ss:1.0.0 --dry-run=client -o yaml > my-private-image-pod2.yaml
```
* add serviceAccountName
```bash
vi my-private-image-pod2.yaml
# serviceAccountName: docker-cred-sa in spec
```
* apply manifest
```bash
kubectl apply -f my-private-image-pod2.yaml
```
* get pods
```
kubectl get po
```
* kubectl events pods
```bash
57s                     Normal    Pulling     Pod/my-private-image-pod2   Pulling image "vijaydevops2012/ss:1.0.0"
57s                     Normal    Scheduled   Pod/my-private-image-pod2   Successfully assigned default/my-private-image-pod2 to control-plane
21s                     Normal    Started     Pod/my-private-image-pod2   Started container my-private-image-pod2
21s                     Normal    Created     Pod/my-private-image-pod2   Created container my-private-image-pod2
21s                     Normal    Pulled      Pod/my-private-image-pod2   Successfully pulled image "vijaydevops2012/ss:1.0.0" in 35.218s (35.218s including waiting). Image size: 517634537 bytes.
```

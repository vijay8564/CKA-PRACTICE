 * openssl genrsa -out tls.key 2048
 *  openssl req -new -key tls.key -out tls.csr
 *  openssl x509 -req -in tls.csr -signkey tls.key -out tls.crt -days 365
 * kubectl create secret tls nginx-tls-secret   --cert=tls.crt   --key=tls.key
 * kubectl apply -f configmap.yaml
 * kubectl apply -f pod.yaml
 * kubectl apply -f service.yaml
 * acces the application from node-ip:<port>

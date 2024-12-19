# configMaps

* In Kubernetes, ConfigMaps are used to store non-confidential configuration data in key-value pairs.
* They can be consumed by Pods to decouple configuration details from the application code. There are different ways to create and use ConfigMaps based on the specific requirements.

## Types of ConfigMaps in Kubernetes
### Literal Key-Value Pair ConfigMap
### ConfigMap from a File
### ConfigMap from Multiple Files
### ConfigMap from Environment Variables
### ConfigMap with Binary Data
#### Let's explore each type with examples.

# Using ConfigMaps in Pods
* Example Pod using a ConfigMap
* You can use ConfigMaps in a Pod by mounting them as volumes or injecting them as environment variables.

* `pod-using-configmap.yaml`
```bash
apiVersion: v1
kind: Pod
metadata:
  name: configmap-pod
spec:
  containers:
    - name: my-container
      image: nginx
      env:
        - name: APP_NAME
          valueFrom:
            configMapKeyRef:
              name: my-literal-config
              key: app.name
        - name: APP_VERSION
          valueFrom:
            configMapKeyRef:
              name: my-literal-config
              key: app.version
      volumeMounts:
        - name: config-volume
          mountPath: /etc/config
  volumes:
    - name: config-volume
      configMap:
        name: my-file-config
```

* **Explanation:**

* `Environment Variables`: APP_NAME and APP_VERSION get their values from the my-literal-config ConfigMap.
* `Mounted Volume`: The my-file-config ConfigMap is mounted at /etc/config in the container.

* **Summary of ConfigMap Types**
* Type	Description	Creation Command
* 1.Literal Key-Value	Directly specify key-value pairs.	kubectl create configmap my-config --from-literal=key1=value1
* 2.From File	Create from a single file.	kubectl create configmap my-config --from-file=file.txt
* 3.From Multiple Files	Combine multiple files into one ConfigMap.	kubectl create configmap my-config --from-file=file1.txt --from-file=file2.txt
* 4.From Environment Variables	Create from a .env file.	kubectl create configmap my-config --from-env-file=config.env
* 5.Binary Data	Store base64-encoded binary data.	Manually create a YAML file with binaryData.
*These different types of ConfigMaps help you manage configuration data efficiently and flexibly in Kubernetes.

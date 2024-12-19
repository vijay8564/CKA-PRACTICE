# 2. ConfigMap from a File
* This type of ConfigMap is created from the contents of a file.

* **Example File**
* Create a configuration file, e.g., app.properties:

* `app.properties`
```bash
app.name=my-app
app.version=1.0.0
```
* Create the ConfigMap
```bash
kubectl create configmap my-file-config --from-file=app.properties
```

* Generated ConfigMap (YAML)
```bash
apiVersion: v1
kind: ConfigMap
metadata:
  name: my-file-config
data:
  app.properties: |
    app.name=my-app
    app.version=1.0.0
```

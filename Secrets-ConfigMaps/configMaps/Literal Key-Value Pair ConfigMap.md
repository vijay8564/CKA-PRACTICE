# 1. Literal Key-Value Pair ConfigMap
* This type of ConfigMap is created directly by specifying key-value pairs.

* **Example (YAML)**
* `literal-configmap.yaml`
```bash
apiVersion: v1
kind: ConfigMap
metadata:
  name: my-literal-config
data:
  app.name: "my-app"
  app.version: "1.0.0"
```

* **Using Command-Line**
* Create a ConfigMap using kubectl with key-value pairs directly:
```bash
kubectl create configmap my-literal-config --from-literal=app.name=my-app --from-literal=app.version=1.0.0
```

# 3. ConfigMap from Multiple Files
* You can create a ConfigMap by combining multiple files.

* **Example Files**
* `app.properties`
```bash
app.name=my-app
```

* `db.properties`
```bash
db.host=localhost
db.port=3306
```
* Create the ConfigMap
```bash
kubectl create configmap my-multi-file-config --from-file=app.properties --from-file=db.properties
```

* Generated ConfigMap (YAML)
```bash
apiVersion: v1
kind: ConfigMap
metadata:
  name: my-multi-file-config
data:
  app.properties: |
    app.name=my-app
  db.properties: |
    db.host=localhost
    db.port=3306
```

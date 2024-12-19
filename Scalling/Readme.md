# Scaling applications in Kubernetes can be done in multiple ways, depending on whether you want to scale the number of replicas, scale resources like CPU and memory, or scale using custom metrics.
* `Horizontal Scaling (Scaling Pods)`: Increase or decrease the number of replicas of a deployment using kubectl scale or YAML definitions.
* `Horizontal Pod Autoscaler (HPA)`: Automatically scale the number of replicas based on CPU, memory, or custom metrics.
* `Vertical Scaling (Scaling Resources)`: Adjust CPU and memory requests/limits for individual pods.
* `Cluster Autoscaler`: Scale the number of nodes in the Kubernetes cluster to match resource demands.
* Choose the scaling method based on your application's requirements and how you want to manage resources in your Kubernetes cluster.

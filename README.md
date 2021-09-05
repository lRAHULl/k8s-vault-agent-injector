# K8s Vault Injector agent

- Establish auth between k8s and vault
- Creates Vault roles and policies for accessing secrets from given k8s namespaces
- Creates Serviceaccounts and clusterrolebindings (system:auth-delegator clusterrole) in the given k8s namespaces.
- If the k8s objects (Pods, Deployments, etc..) have the necessary annotations, then a Sidecar / Init containers will be injected into the pods and then sync the mentioned secrets from the vault server to the mentioned file path in the pod.

Example:

```yaml
metadata:
  annotations:
    vault.hashicorp.com/agent-inject: true
    vault.hashicorp.com/role: <configures the vault role used by the injector agent>
    vault.hashicorp.com/secret-volume-path: <custom path for storing secrets> # default: /vault/secrets
    vault.hashicorp.com/agent-inject-secret-<file-name>: <path to the secret in vault> # Your secret will be available at <vault.hashicorp.com/secret-volume-path>/<file-name> . eg: /vault/secrets/<file-name>
```

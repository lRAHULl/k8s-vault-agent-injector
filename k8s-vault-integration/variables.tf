variable "kube_config_path" {
  type = string
  description = "The absolute path for the kubeconfig file."
}

variable "k8s_cluster_name" {
  type        = string
  description = "The name of the k8s cluster."
}

variable "vault_endpoint" {
  type        = string
  description = "Endpoint of the vault server." 
}

variable "k8s_cluster_name" {
  type        = string
  description = "The name of the k8s cluster."
}

variable "namespace" {
  type        = string
  description = "The namespace in which to enable vault injector"
}

variable "k8s_auth_method_path" {
  type = string
  description = "The k8s auth method path in vault to authenticate requests between k8s and vault"
}

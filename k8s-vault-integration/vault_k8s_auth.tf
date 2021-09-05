locals {
  k8s_cluster_name      = var.k8s_cluster_name
  vault_address         = var.vault_endpoint
  k8s_auth_method_path  = "k8s/${local.k8s_cluster_name}"
  kube_config_path      = var.kube_config_path
}

data "external" "kubectl_config_view" {
  program = ["sh", "${path.module}/scripts/kubectl_config_view.sh"]

  query = {
    kubeconfig_path = "/Users/rahulp/.kube/config"
    cluster_name    = local.k8s_cluster_name
  }
}

# Create the Kubernetes auth backend in Vault
resource "vault_auth_backend" "vault_k8s_auth_backend" {
  type        = "kubernetes"
  path        = local.k8s_auth_method_path
  description = "Kubernetes Auth Backend for ${local.k8s_cluster_name} k8s cluster"
}

# Configure the k8s auth backend for this k8s cluster
resource "vault_kubernetes_auth_backend_config" "k8s_config" {
  backend         = vault_auth_backend.vault_k8s_auth_backend.path
  kubernetes_host = data.external.kubectl_config_view.result["server"]
  kubernetes_ca_cert = base64decode(
    data.external.kubectl_config_view.result["certificate-authority-data"],
  )
}

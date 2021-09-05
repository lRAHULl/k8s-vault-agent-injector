locals {
  vault_address    = var.vault_address
  kube_config_path = var.kube_config_path
  k8s_cluster_name = var.k8s_cluster_name
}

module "k8s_vault_integration" {
  source = "../k8s-vault-integration"

  providers = {
    vault = vault
  }

  k8s_cluster_name = local.k8s_cluster_name
  vault_endpoint   = local.vault_address
  kube_config_path = local.kube_config_path
}

module "vault_agent" {
  source = "../vault-agent"

  providers = {
    helm = helm
  }

  namespace            = var.vault_agent_injector_ns
  k8s_auth_method_path = module.k8s_vault_integration.vault_k8s_auth_backend_path
}

module "vault_agent_enable_default_ns" {
  source = "../vault-agent-ns-reqs"

  providers = {
    vault      = vault
    kubernetes = kubernetes
  }

  k8s_cluster_name     = local.k8s_cluster_name
  namespace            = "default"
  k8s_auth_method_path = module.k8s_vault_integration.vault_k8s_auth_backend_path
}

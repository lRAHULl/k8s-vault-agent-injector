resource "kubernetes_service_account" "vault_agent_sa" {
  metadata {
    name      = "${var.namespace}-vault-injector-agent"
    namespace = var.namespace
  }
}

resource "kubernetes_cluster_role_binding" "vault_agent_crb" {
  metadata {
    name = "${kubernetes_service_account.vault_agent_sa.metadata[0].name}-access"
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = "system:auth-delegator"
  }
  subject {
    kind      = "ServiceAccount"
    name      = kubernetes_service_account.vault_agent_sa.metadata[0].name
    namespace = var.namespace
  }
}

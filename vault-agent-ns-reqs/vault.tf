# Create vault policy with appropriate permissions.
resource "vault_policy" "vault_injector_agent" {
  name = "k8s/${var.k8s_cluster_name}/${var.namespace}/vault-injector-agent"

  policy = <<EOT
path "sys/mounts" { capabilities = ["read"] }
path "secret/data/${var.namespace}/*" { capabilities = ["read"] }
path "secret/metadata/${var.namespace}/*" { capabilities = ["list"] }
EOT
}

# Create vault role with the above policy for usage in k8s.
resource "vault_kubernetes_auth_backend_role" "vault_injector_agent" {
  backend                          = var.k8s_auth_method_path
  role_name                        = "${var.namespace}-vault-injector-agent-role"
  bound_service_account_names      = ["*"]
  bound_service_account_namespaces = [var.namespace]
  token_policies                   = [vault_policy.vault_injector_agent.name]
}

output "vault_injector_agent_role" {
  value = vault_kubernetes_auth_backend_role.vault_injector_agent.role_name
}

output "vault_injector_agent_policy" {
  value = vault_policy.vault_injector_agent.name
}

output "vault_injector_agent_access_serviceaccount" {
  value = kubernetes_service_account.vault_agent_sa.metadata[0].name
}

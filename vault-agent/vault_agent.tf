locals {
  k8s_cluster_name      = "rahul-tanzu-mgmt-cluster"
  vault_address         = "http://3.93.172.153:8200/"
  k8s_auth_method_path  = var.k8s_auth_method_path
}

locals {
  values_yaml = templatefile("${abspath(path.root)}/${path.module}/templates/vault_injector_agent_values.yaml.tpl",
    {
      vault_address       = local.vault_address
      vault_k8s_auth_path = local.k8s_auth_method_path

      replica_count = var.injector_replica_count

      object_selector = jsonencode(var.injector_object_selector)

      agent_cpu_req   = lookup(var.injected_sidecar_agent_resources, "cpu_req")
      agent_cpu_limit = lookup(var.injected_sidecar_agent_resources, "cpu_limit")
      agent_mem_req   = lookup(var.injected_sidecar_agent_resources, "mem_req")
      agent_mem_limit = lookup(var.injected_sidecar_agent_resources, "mem_limit")

      cpu_req   = lookup(var.injector_resources, "cpu_req")
      cpu_limit = lookup(var.injector_resources, "cpu_limit")
      mem_req   = lookup(var.injector_resources, "mem_req")
      mem_limit = lookup(var.injector_resources, "mem_limit")

      log_level  = var.injector_log_level
      log_format = var.injector_log_format

      failure_policy = var.injector_failure_policy

      create_injector_agent_sa = var.create_injector_agent_sa
    }
  )
}

resource "helm_release" "vault" {
  name         = "${var.namespace}-vault-injector-agent-controller"
  repository   = "https://helm.releases.hashicorp.com"
  chart        = "vault"
  version      = "0.12.0"
  namespace    = var.namespace
  values       = [local.values_yaml]
  force_update = false
  max_history  = "10"
  timeout      = "600"
  lint         = true
  atomic       = true
  reset_values = true
}

global:
  enabled: true

injector:
  enabled: true
  replicas: ${replica_count}

  externalVaultAddr: "${vault_address}"
  authPath: "auth/${vault_k8s_auth_path}"
  
  agentDefaults:
    cpuLimit: "${agent_cpu_limit}"
    cpuRequest: "${agent_cpu_req}"
    memLimit: "${agent_mem_limit}"
    memRequest: "${agent_mem_req}"

  resources:
    requests:
      memory: ${mem_req}
      cpu: ${cpu_req}
    limits:
      memory: ${mem_limit}
      cpu: ${cpu_limit}

  objectSelector: ${object_selector}

  logLevel: "${log_level}"
  logFormat: "${log_format}"

  failurePolicy: ${failure_policy}

server:
  serviceAccount:
    create: ${create_injector_agent_sa}

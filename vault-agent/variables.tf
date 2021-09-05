variable "namespace" {
  type = string
}

variable "k8s_auth_method_path" {
  type = string
  description = "The k8s auth method path in vault to authenticate requests between k8s and vault"
}

variable "injector_replica_count" {
  type        = number
  description = "Number of sidecar injector replicas"
  default     = 1
}

variable "injector_resources" {
  type = object({
    cpu_req   = string
    mem_req   = string
    cpu_limit = string
    mem_limit = string
  })
  default = {
    cpu_req   = "250m"
    mem_req   = "256Mi"
    cpu_limit = "500m"
    mem_limit = "512Mi"
  }
  description = "Sidecar injector pod's resource requests and limits"
}

variable "injected_sidecar_agent_resources" {
  type = object({
    cpu_req   = string
    mem_req   = string
    cpu_limit = string
    mem_limit = string
  })
  default = {
    cpu_req   = "250m"
    mem_req   = "64Mi"
    cpu_limit = "500m"
    mem_limit = "128Mi"
  }
  description = "Injected container agent (the actual sidecar in the pod) resource requests and limits"
}

variable "injector_log_level" {
  type        = string
  default     = "info"
  description = "Configures the log verbosity of the injector. Supported log levels: trace, debug, error, warn, info"
}

variable "injector_log_format" {
  type        = string
  default     = "standard"
  description = "Configures the log format of the injector. Supported log formats: standard, json"
}

variable "injector_failure_policy" {
  default     = "Ignore"
  type        = string
  description = "When set to Fail, an error calling the webhook causes the admission to fail and the API request to be rejected. When set to Ignore, an error calling the webhook is ignored and the API request is allowed to continue. Allowed values: Fail, Ignore"
}

variable "injector_object_selector" {
  type        = any
  default     = {}
  description = "The selector used by the admission webhook controller to limit what objects can be effected by mutation. By default all object with correct annotations will be targeted."
}

variable "create_injector_agent_sa" {
  type        = bool
  default     = false
  description = "Whether to create a bundled service_account that has access to tokenreviews api, this is usually created using `tf-k8s-vault-injector-agent-prereqs` module"
}

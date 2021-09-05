# Export the vault root token in the current bash session
provider "vault" {
  address         = local.vault_address
}

provider "helm" {
  kubernetes {
    config_path = local.kube_config_path
  }
}

provider "kubernetes" {
  config_path = local.kube_config_path
}

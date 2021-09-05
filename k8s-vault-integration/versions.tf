terraform {
  required_version = ">= 0.12.31"
  required_providers {
    vault = {
      source  = "hashicorp/vault"
      version = ">= 2.7"
    }
  }
}

terraform {
  required_version = ">= 0.12.31"
  required_providers {
    helm = {
      source  = "hashicorp/helm"
      version = ">= 1.0"
    }
  }
}

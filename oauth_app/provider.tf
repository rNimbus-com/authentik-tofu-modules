terraform {
  required_version = ">= 1.6"
  required_providers {
    random = {
      source  = "hashicorp/random"
      version = ">=3.7"
    }
    authentik = {
      source  = "goauthentik/authentik"
      version = ">=2025.10.0"
    }
  }
}
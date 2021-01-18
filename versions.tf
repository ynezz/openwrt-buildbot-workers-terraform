terraform {
  required_providers {
    hcloud = {
      source  = "hetznercloud/hcloud"
      version = "1.24.0"
    }
    local = {
      source  = "hashicorp/local",
      version = "2.0.0"
    }
    template = {
      source  = "hashicorp/template",
      version = "2.2.0"
    }
  }
}

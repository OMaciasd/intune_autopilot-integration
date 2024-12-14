provider "azuread" {
  tenant_id = "tu-tenant-id"
}
terraform {
  required_providers {
    azuread = {
      source  = "hashicorp/azuread"
      version = ">=2.0.0"
    }
  }
}

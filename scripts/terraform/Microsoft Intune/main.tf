terraform {
  required_providers {
    azuread = {
      source  = "hashicorp/azuread"
      version = ">=2.32.0"
    }
  }
}

provider "azuread" {
  tenant_id = "tu-tenant-id"
}

resource "azuread_conditional_access_policy" "example" {
  display_name = "Secure Access"
  state        = "enabled" # Puede ser "enabled", "disabled" o "enabledForReportingButNotEnforced".

  conditions {
    users {
      include = ["All"] # Se puede reemplazar por los IDs específicos de usuarios.
    }

    devices {
      device_states {
        include = ["compliant"]
      }
    }

    applications {
      include_applications = ["All"] # Se puede reemplazar por los IDs específicos de aplicaciones.
    }
  }

  client_app_types = [
    "browser",                    # Tipos de clientes permitidos
    "mobileAppsAndDesktopClients" # Para dispositivos móviles y clientes de escritorio
  ]

  grant_controls {
    operator          = "OR"
    built_in_controls = ["mfa"] # Autenticación multifactor como control de acceso
  }
}

resource "azuread_conditional_access_policy" "example" {
  display_name = "Secure Access"
  conditions = {
    users   = ["all_users"]
    devices = ["compliant"]
  }
}

resource "azuread_password_policy" "policy" {
  minimum_password_length = 12
  require_numbers         = true
  password_expiry_days    = 90
}

resource "azuread_update_policy" "updates" {
  automatic_updates = true
}

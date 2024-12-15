provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "example" {
  name     = "example-resources"
  location = "East US"
}

resource "azurerm_device_configuration" "example" {
  name                = "WindowsAutopilotConfig"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location

  description = "Device configuration for Windows Autopilot"
}
resource "microsoft_intune_autopilot_deployment_profile" "default_profile" {
  display_name                  = "Autopilot Default Profile"
  description                   = "Deployment profile for Windows devices"
  out_of_box_experience_enabled = true
  language                      = "en-US"
  region                        = "US"
  user_principal_name           = "user@domain.com"
  device_name_template          = "Device-%SERIAL%"
  enable_white_glove            = false
}

resource "microsoft_intune_autopilot_device" "device_registration" {
  count            = length(var.devices)
  order_identifier = var.devices[count.index].order_identifier
  serial_number    = var.devices[count.index].serial_number
  product_key      = var.devices[count.index].product_key
  group_tag        = var.devices[count.index].group_tag
}

resource "null_resource" "register_device" {
  provisioner "local-exec" {
    command = "python register_autopilot_device.py"
  }
}

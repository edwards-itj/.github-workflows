provider "azurerm" {
  features {}
  subscription_id = "d0562237-de19-4716-bc0d-88b684f5f733"
}

resource "azurerm_resource_group" "this" {
  name     = "rg-opa-terraform"
  location = "West Europe"
}

data "azurerm_client_config" "current" {}
  
resource "azurerm_public_ip" "deny" {
  name = "pip-test-opa-terraform"
  location = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  allocation_method = "Static"
  sku = "Standard"
}

module "child_module_deny" {
  source = "./module/public_ip"
}

module "child_module_allow" {
  source = "./module/resource_group"
}
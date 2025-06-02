resource "azurerm_resource_group" "this" {
  name     = "rg-opa-terraform-deny"
  location = "West Europe"
}

resource "azurerm_public_ip" "deny" {
  name = "pip-test-opa-terraform"
  location = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  allocation_method = "Static"
  sku = "Standard"
}
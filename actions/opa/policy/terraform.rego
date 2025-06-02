package terraform

# List of denied Azure resource types
allowed_resource_types := {
  "azurerm_resource_group",
  "azurerm_network_security_group",
  "azurerm_virtual_machine",
  # Add more resource types as needed
}

deny contains msg if {
  some k
  resource_type := input.resource_changes[k].type
  address := input.resource_changes[k].address
  mode := input.resource_changes[k].mode

  mode == "managed" # We don't need to block read only data operations
  not allowed_resource_types[resource_type]
  msg := sprintf("Resource type '%s' is not allowed. %s", [resource_type, address])
}
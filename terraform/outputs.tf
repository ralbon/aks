output "vnet_name" {
  value = azurerm_virtual_network.vnet.name
}
output "subnet_name" {
  value = azurerm_subnet.subnet.name
}

output "resource_group_name" {
  value = var.resource_group_name
}

output "resource_group_location" {
  value = var.resource_group_location
}
resource "azurerm_virtual_network" "vnet" {
  name                = "${local.name}-vnet"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  address_space       = [var.vnet_address_space]

  tags = local.tags
}

resource "azurerm_subnet" "subnet" {
  name                 = "${local.name}-subnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [var.subnet_address_prefix]
}

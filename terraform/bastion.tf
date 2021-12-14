resource "azurerm_subnet" "bastion" {
  name                 = "bastion-subnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_network_interface" "bastion" {
  name                = "bastion"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "configuration"
    subnet_id                     = azurerm_subnet.bastion.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_virtual_machine" "bastion" {
  name                  = "bastion"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  network_interface_ids = [azurerm_network_interface.bastion.id]
  vm_size               = "Standard_DS1_v2"

  delete_os_disk_on_termination = true
  delete_data_disks_on_termination = true

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }
  storage_os_disk {
    name              = "myosdisk1"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  os_profile {
    computer_name  = "hostname"
    admin_username = "loreal"
    admin_password = var.bastion_password
    custom_data    = file("../bastion-user-data.sh")
  }
  os_profile_linux_config {
    disable_password_authentication = false
  }
  tags = {
    environment = "staging"
  }
}
resource "azurerm_subnet" "bastionazure" {
  name                 = "AzureBastionSubnet"
  resource_group_name = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.10.0/24"]
}


resource "azurerm_public_ip" "bastionazure" {
  name                = "bastionazure"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_bastion_host" "bastionazure" {
  name                = "bastionazure"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                 = "configuration"
    subnet_id            = azurerm_subnet.bastionazure.id
    public_ip_address_id = azurerm_public_ip.bastionazure.id
  }
}


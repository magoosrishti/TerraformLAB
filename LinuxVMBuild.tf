resource "azurerm_resource_group" "RGNew" {
  name     = "SrishtiRG"
  location = "West Europe"
}

resource "azurerm_virtual_network" "RG_VNET" {
  name                = "Srishti-network"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.RGNew.location
  resource_group_name = azurerm_resource_group.RGNew.name
}

resource "azurerm_subnet" "RG_subnet" {
  name                 = "internal"
  resource_group_name  = azurerm_resource_group.RGNew.name
  virtual_network_name = azurerm_virtual_network.RG_VNET.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_network_interface" "NIC" {
  name                = "Srishti-nic"
  location            = azurerm_resource_group.RGNew.location
  resource_group_name = azurerm_resource_group.RGNew.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.RG_subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "LinuxVM" {
  name                = "Srishti-LinuxVM"
  resource_group_name = azurerm_resource_group.RGNew.name
  location            = azurerm_resource_group.RGNew.location
  size                = "Standard_F2"
  disable_password_authentication = false
  admin_username      = "adminuser"
  admin_password      = "P@$$w0rd1234!"
  network_interface_ids = [
    azurerm_network_interface.NIC.id,
  ]

    os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }
}
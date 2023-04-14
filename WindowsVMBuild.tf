resource "azurerm_network_interface" "SrishtiNIC" {
  name                = "Srishti-nic1"
  location            = azurerm_resource_group.RGNew.location
  resource_group_name = azurerm_resource_group.RGNew.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.RG_subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_windows_virtual_machine" "WindowsVM" {
  name                = "WindowsVM"
  resource_group_name = azurerm_resource_group.RGNew.name
  location            = azurerm_resource_group.RGNew.location
  size                = "Standard_F2"
  admin_username      = "adminuser"
  admin_password      = "P@$$w0rd1234!"
  network_interface_ids = [
    azurerm_network_interface.SrishtiNIC.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter"
    version   = "latest"
  }
}
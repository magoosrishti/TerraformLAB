# Resource Block
# Create a resource group
resource "azurerm_resource_group" "rg-new" {
  name = "SrishtiRG"
  location = "East US"
  tags = {
    env = var.env-tag
  }
}

resource "azurerm_virtual_network" "rg-new" {
  name                = "Srishti-VNET"
  location            = azurerm_resource_group.rg-new.location
  resource_group_name = azurerm_resource_group.rg-new.name
  tags = {
    env = var.env-tag
  }
  address_space       = var.vnet-address_space
}

resource "azurerm_resource_group" "backend" {
  name = "backend"
  location = "East US"
  tags = {
    env = var.env-tag
  }
}
resource "azurerm_storage_account" "import_example" {
  name                     = "storagebackend2023"
  resource_group_name      = azurerm_resource_group.backend.name
  location                 = azurerm_resource_group.backend.location
  account_tier             = "Standard"
  account_replication_type = "RAGRS"

  tags = {
    environment = "staging"
  }
}
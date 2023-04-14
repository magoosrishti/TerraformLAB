terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.51.0"
    }
  }
backend "azurerm" {
 resource_group_name = "backend"
 storage_account_name = "storagebackend2023"
 container_name =  "backend"
 key = "prodenv.tfstate"
}
}
provider "azurerm" {
  # Configuration options
features{}
}

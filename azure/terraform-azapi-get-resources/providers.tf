terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.74.0"
    }
    azapi = {
      source  = "azure/azapi"
      version = "~>2.10"
    }
  }
}

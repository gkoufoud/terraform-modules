terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>4.74"
    }
    azapi = {
      source  = "azure/azapi"
      version = "~>2.10"
    }
  }
}

provider "azurerm" {
  features {}
}

provider "azapi" {}

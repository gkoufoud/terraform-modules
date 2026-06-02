variable "aks_cluster" { # format: resourcegroup/clustername
  type        = string
  description = "The resource group and name of the AKS cluster to create a federated identity credential for. Format: resourcegroup/clustername."
  validation {
    condition     = var.aks_cluster == "" || length(split("/", var.aks_cluster)) == 2
    error_message = "aks_cluster must be in the format resourcegroup/clustername."
  }
  default = ""
}

module "managed_identity_example" {
  source = "../../../azure/terraform-azurerm-managed-identity"
  # source                            = "git::https://github.com/gkoufoud/terraform-modules.git//azure/terraform-azurerm-get-keyvault-secret"
  name                = "example-managed-identity"
  resource_group_name = "example-resource-group"
  location            = "uksouth"
  tags = {
    environment = "prod"
  }
}

data "azurerm_kubernetes_cluster" "example" {
  count               = length(split("/", var.aks_cluster)) == 2 ? 1 : 0
  name                = split("/", var.aks_cluster)[1]
  resource_group_name = split("/", var.aks_cluster)[0]
}


module "managed_identity_fc_example" {
  count  = length(split("/", var.aks_cluster)) == 2 ? 1 : 0
  source = "../../../azure/terraform-azurerm-managed-identity"
  # source                            = "git::https://github.com/gkoufoud/terraform-modules.git//azure/terraform-azurerm-get-keyvault-secret"
  # for_each = length(split("/", var.aks_cluster)) == 2 ? toset([1]) : toset([])
  name                = "example-managed-identity-fc"
  resource_group_name = "example-resource-group"
  location            = "uksouth"
  tags = {
    environment = "prod"
  }
  federated_identity_credentials = [
    {
      name                 = "example-federated-credential"
      issuer               = data.azurerm_kubernetes_cluster.example[0].oidc_issuer_url
      namespace            = "default"
      service_account_name = "example-service-account"
    }
  ]
}

output "managed_identity_example_id" {
  value = module.managed_identity_example.managed_identity.id
}

output "managed_identity_fc_example_id" {
  value = length(split("/", var.aks_cluster)) == 2 ? module.managed_identity_fc_example[0].managed_identity.id : ""
}

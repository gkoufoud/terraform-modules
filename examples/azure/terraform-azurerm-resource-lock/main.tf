variable "aks_cluster" { # format: resourcegroup/clustername
  type        = string
  description = "The resource group and name of the AKS cluster to create a federated identity credential for. Format: resourcegroup/clustername."
  validation {
    condition     = length(split("/", var.aks_cluster)) == 2
    error_message = "aks_cluster must be in the format resourcegroup/clustername."
  }
}

data "azurerm_kubernetes_cluster" "example" {
  name                = split("/", var.aks_cluster)[1]
  resource_group_name = split("/", var.aks_cluster)[0]
}


module "aks_lock" {
  source     = "git::https://github.com/gkoufoud/terraform-modules.git//azure/terraform-azurerm-resource-lock"
  lock_name  = "example-aks-lock"
  scope      = data.azurerm_kubernetes_cluster.example.id
  lock_level = "CanNotDelete"
  notes      = "This lock prevents deletion of the AKS cluster."
}

output "aks_lock_id" {
  value = module.aks_lock.lock.id
}

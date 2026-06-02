variable "aks_cluster_name" {
  type        = string
  default     = "valid_cluster_name"
  description = "The name of the AKS cluster to validate."
}

module "aks_cluster_name_validation" {
  source        = "git::https://github.com/gkoufoud/terraform-modules.git//azure/terraform-azurerm-resource-name-validation"
  resource_type = "aks"
  resource_name = var.aks_cluster_name
}

output "aks_cluster_name_validation_result" {
  value = module.aks_cluster_name_validation.value
}

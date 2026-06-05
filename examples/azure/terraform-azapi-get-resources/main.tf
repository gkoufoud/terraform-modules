variable "key_vault_name" {
  type        = string
  description = "The name of the Key Vault to filter by."
  default     = "mykeyvault"
}

module "resource_by_name_return_all_attributes" {
  source = "git::https://github.com/gkoufoud/terraform-modules.git//azure/terraform-azapi-get-resources"
  type   = "microsoft.keyvault/vaults"
  name   = var.key_vault_name
}

module "resource_by_name_return_id" {
  source            = "git::https://github.com/gkoufoud/terraform-modules.git//azure/terraform-azapi-get-resources"
  type              = "microsoft.keyvault/vaults"
  name              = var.key_vault_name
  return_attributes = ["id"]
}

module "resource_by_tags_return_all_attributes" {
  source = "git::https://github.com/gkoufoud/terraform-modules.git//azure/terraform-azapi-get-resources"
  type   = "microsoft.keyvault/vaults"
  tags = {
    "Usage"       = "infra"
    "Environment" = "prod"
  }
}

output "resource_by_name_return_all_attributes" {
  value = module.resource_by_name_return_all_attributes.resources
}

output "resource_by_name_return_id" {
  value = length(module.resource_by_name_return_id.resources) > 0 ? module.resource_by_name_return_id.resources[0].id : ""
}

output "resource_by_tags_return_all_attributes" {
  value = length(module.resource_by_tags_return_all_attributes.resources) > 0 ? module.resource_by_tags_return_all_attributes.resources[0].id : ""
}

variable "key_vault_name" {
  type        = string
  description = "The name of the Key Vault to filter by."
  default     = ""
}

variable "key_vault_resource_group_name" {
  type        = string
  description = "The name of the resource group containing the Key Vault."
  default     = ""
}

variable "key_vault_id" {
  type        = string
  description = "The ID of the Key Vault to filter by."
  default     = ""
}

variable "key_vault_secret_name" {
  type        = string
  description = "The name of the Key Vault secret to retrieve."
  validation {
    condition     = var.key_vault_secret_name != ""
    error_message = "key_vault_secret_name must be a non-empty string."
  }
}

variable "key_vault_tags" {
  type        = map(string)
  description = "A map of tag key/value pairs to match the Key Vault."
  default     = {}
}

module "get_key_vault_secret" {
  source                            = "../../../azure/terraform-azurerm-get-keyvault-secret"
  secret_name                       = var.key_vault_secret_name
  key_vault_resource_group_and_name = var.key_vault_resource_group_name != "" && var.key_vault_name != "" ? "${var.key_vault_resource_group_name}/${var.key_vault_name}" : ""
  key_vault_id                      = var.key_vault_id
  key_vault_tags                    = var.key_vault_tags
}

output "key_vault_secret_value" {
  value     = module.get_key_vault_secret.value
  sensitive = true
}

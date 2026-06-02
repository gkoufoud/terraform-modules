variable "secret_name" {
  type        = string
  description = "The name of the Key Vault secret to retrieve."
  validation {
    condition     = length(var.secret_name) > 0
    error_message = "secret_name must be a non-empty string."
  }
}

variable "key_vault_id" {
  type        = string
  default = ""
  description = "The ID of the Key Vault from which to retrieve the secret."
  validation {
    condition     = var.key_vault_id == "" || can(regex("(?i)^(/subscriptions/[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}(/resourceGroups/[^/]+)?|/providers/[^/]+(/[^/]+)+)(/providers/[^/]+(/[^/]+){1,})?$", var.key_vault_id))
    error_message = "key_vault_id must be a valid Azure resource ID for a subscription, resource group, or resource."
  }
}


variable "key_vault_tags" {
  type        = map(string)
  description = "A map of tag key/value pairs to match the Key Vault."
  default     = {}
}


variable "key_vault_resource_group_and_name" { # format: resource-group/name
    type = string
    default = ""
    description = "The resource group and name to identify the Key Vault from which to retrieve the secret. Format: resource-group/name."
    validation {
        condition     = var.key_vault_resource_group_and_name == "" || can(regex("^[^/]+/[^/]+$", var.key_vault_resource_group_and_name))
        error_message = "key_vault_resource_group_and_name must be in the format 'resource-group/name'."
    }
}
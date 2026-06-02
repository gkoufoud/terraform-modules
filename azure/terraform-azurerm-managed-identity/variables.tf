variable "name" {
  type        = string
  description = "The name of the managed identity."
  validation {
    condition     = length(var.name) > 3
    error_message = "Name must be at least 4 characters long."
  }
}

variable "resource_group_name" {
  type        = string
  description = "The name of the resource group containing the managed identity."
  validation {
    condition     = length(var.resource_group_name) > 3
    error_message = "resource_group_name must be at least 4 characters long."
  }
}

variable "location" {
  type        = string
  description = "The location of the managed identity."
  default     = "uksouth"
}

variable "tags" {
  type        = map(string)
  description = "A map of tags to assign to the managed identity."
  default     = {}
}

variable "federated_identity_credentials" {
  type = list(object({
    name                 = string
    issuer               = string
    namespace            = string
    service_account_name = string
    audience             = optional(list(string), ["api://AzureADTokenExchange"])
  }))
  description = "A list of federated identity credentials to create for the managed identity."
  default     = []
}

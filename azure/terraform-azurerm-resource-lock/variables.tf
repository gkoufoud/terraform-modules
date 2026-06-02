variable "lock_name" {
  type        = string
  description = "The name of the Management Lock."
}

variable "scope" {
  type        = string
  description = "The ID of the Scope where the Lock should be applied (e.g., Resource ID, Resource Group ID, or Subscription ID)."
  validation {
    condition     = can(regex("(?i)^(/subscriptions/[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}(/resourceGroups/[^/]+)?|/providers/[^/]+(/[^/]+)+)(/providers/[^/]+(/[^/]+){1,})?$", var.scope))
    error_message = "scope must be a valid Azure resource ID for a subscription, resource group, or resource."
  }
}

variable "lock_level" {
  type        = string
  description = "The level of the lock. Valid values are 'CanNotDelete' or 'ReadOnly'."

  validation {
    condition     = contains(["CanNotDelete", "ReadOnly"], var.lock_level)
    error_message = "The lock_level must be exactly 'CanNotDelete' or 'ReadOnly'."
  }
}

variable "notes" {
  type        = string
  description = "(Optional) A description or note for the lock."
  default     = null
}

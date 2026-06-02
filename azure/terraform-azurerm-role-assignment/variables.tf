variable "role_assignment_name" {
  type        = string
  description = "The name of the role assignment."
  default     = null

  validation {
    condition     = var.role_assignment_name == null || can(regex("^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$", var.role_assignment_name))
    error_message = "If set, role_assignment_name must be a GUID string."
  }
}

variable "principal_type" {
  type        = string
  description = "The type of the principal. Valid values are 'User', 'Group', 'ServicePrincipal'."
  default     = null

  validation {
    condition     = var.principal_type == null || contains(["User", "Group", "ServicePrincipal"], var.principal_type)
    error_message = "If set, principal_type must be one of 'User', 'Group', 'ServicePrincipal'."
  }
}

variable "principal_id" {
  type        = string
  description = "The object ID of the principal to which the role will be assigned."
  validation {
    condition     = can(regex("^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$", var.principal_id))
    error_message = "principal_id must be a GUID string."
  }
}

variable "role_definition_id" {
  type        = string
  default     = null
  description = "The ID of the role definition to assign. This can be a built-in role ID or a custom role ID."
  validation {
    condition     = var.role_definition_id == null || can(regex("^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$", var.role_definition_id))
    error_message = "If set, the role_definition_id must be a GUID string."
  }
}

variable "role_definition_name" {
  type        = string
  default     = null
  description = "The name of the role definition to assign. This can be a built-in role name or a custom role name."
  validation {
    condition     = var.role_definition_name == null || length(var.role_definition_name) > 3
    error_message = "If set, the role_definition_name must be at least 4 characters long."
  }
}

variable "scope" {
  type        = string
  description = "The scope at which the role assignment applies. This can be a subscription, resource group, or resource ID."
  validation {
    condition     = can(regex("(?i)^(/subscriptions/[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}(/resourceGroups/[^/]+)?|/providers/[^/]+(/[^/]+)+)(/providers/[^/]+(/[^/]+){1,})?$", var.scope))
    error_message = "scope must be a valid Azure resource ID for a subscription, resource group, or resource."
  }
}


variable "name" {
  type        = string
  description = "The name of the private endpoint."
  validation {
    condition     = length(var.name) > 1
    error_message = "Name must be at least 2 characters long."
  }
}

variable "resource_group_name" {
  type        = string
  description = "The name of the resource group containing the private endpoint."
  validation {
    condition     = length(var.resource_group_name) > 0
    error_message = "resource_group_name must be at least 1 character long."
  }
}

variable "location" {
  type        = string
  description = "The location of the private endpoint."
  default     = "uksouth"
}

variable "tags" {
  type        = map(string)
  description = "A map of tags to assign to the private endpoint."
  default     = {}
}

variable "subnet_id" {
  type        = string
  description = "The ID of the subnet to associate with the private endpoint."
  validation {
    condition     = can(regex("^/subscriptions/.+/resourceGroups/.+/providers/Microsoft.Network/virtualNetworks/.+/subnets/.+$", var.subnet_id))
    error_message = "subnet_id must be a valid Azure subnet ID."
  }
}

variable "custom_network_interface_name" {
  type        = string
  description = "The name of the custom network interface to create for the private endpoint."
  default     = null
}

variable "private_dns_zone_group" {
  type = object({
    name                 = string
    private_dns_zone_ids = list(string)
  })
  description = "An optional block to configure a private DNS zone group for the private endpoint."
  default     = null
  validation {
    condition = var.private_dns_zone_group == null || (
      length(var.private_dns_zone_group.name) > 3 &&
      length(var.private_dns_zone_group.private_dns_zone_ids) > 0 &&
      alltrue([
        for id in var.private_dns_zone_group.private_dns_zone_ids : can(regex("^/subscriptions/[^/]+/resourceGroups/[^/]+/providers/Microsoft\\.Network/privateDnsZones/[^/]+$", id))
      ])
    )
    error_message = "If private_dns_zone_group is provided, name must be at least 4 characters long, private_dns_zone_ids must contain at least one ID, and each ID must be a valid Private DNS zone resource ID."
  }
}

variable "private_service_connection" {
  type = object({
    name                              = string
    is_manual_connection              = optional(bool, false)
    private_connection_resource_id    = optional(string)
    private_connection_resource_alias = optional(string)
    subresource_names                 = optional(list(string))
    request_message                   = optional(string)
  })
  description = "A block to configure the private service connection for the private endpoint."
  validation {
    condition = (
      length(var.private_service_connection.name) > 3 &&
      (
        (try(length(trimspace(var.private_service_connection.private_connection_resource_id)), 0) > 0 ? 1 : 0) +
        (try(length(trimspace(var.private_service_connection.private_connection_resource_alias)), 0) > 0 ? 1 : 0)
      ) == 1 &&
      (
        try(length(trimspace(var.private_service_connection.private_connection_resource_id)), 0) == 0 ||
        can(regex("^/subscriptions/[^/]+/resourceGroups/[^/]+/providers/.+$", var.private_service_connection.private_connection_resource_id))
      ) &&
      (
        (
          try(var.private_service_connection.subresource_names, null) == null ||
          (
            length(var.private_service_connection.subresource_names) == 1 &&
            contains(
              keys(local.private_link_subresources_by_resource_type),
              try(lower(join("/", slice(split("/", trimspace(var.private_service_connection.private_connection_resource_id)), 6, 8))), "")
            ) &&
            alltrue([
              for name in var.private_service_connection.subresource_names : contains(
                local.private_link_subresources_by_resource_type[try(lower(join("/", slice(split("/", trimspace(var.private_service_connection.private_connection_resource_id)), 6, 8))), "")],
                lower(trimspace(name))
              )
            ]) &&
            length(distinct([
              for name in var.private_service_connection.subresource_names : lower(trimspace(name))
            ])) == length(var.private_service_connection.subresource_names)
          )
        ) &&
        (
          try(length(trimspace(var.private_service_connection.private_connection_resource_alias)), 0) == 0 ||
          try(var.private_service_connection.subresource_names, null) == null
        )
      ) &&
      (
        var.private_service_connection.is_manual_connection ||
        try(length(trimspace(var.private_service_connection.request_message)), 0) == 0
      ) &&
      (
        try(length(var.private_service_connection.request_message), 0) <= 140
      )
    )
    error_message = "private_service_connection.name must be at least 4 characters long; exactly one of private_connection_resource_id or private_connection_resource_alias must be set; private_connection_resource_id must be a valid Azure resource ID when provided; subresource_names must contain exactly one value when provided, and that value must be valid for the resource type in private_connection_resource_id (for example, Microsoft.Automation/automationAccounts allows only webhook or dscandhybridworker); when using private_connection_resource_alias, omit subresource_names; request_message is only valid when is_manual_connection is true and must be 140 characters or fewer."
  }
}

variable "ip_configurations" {
  type = list(object({
    name               = optional(string) # If not provided, a default name will be generated.
    private_ip_address = string
    subresource_name   = optional(string)
  }))
  description = "An optional list of custom IP configurations for the private endpoint."
  default     = []

  validation {
    condition = (
      alltrue([
        for cfg in var.ip_configurations : (
          can(cidrhost("${trimspace(cfg.private_ip_address)}/32", 0)) &&
          (
            try(cfg.name, null) == null ||
            length(trimspace(cfg.name)) > 0
          ) &&
          (
            try(cfg.subresource_name, null) == null ||
            (
              length(trimspace(cfg.subresource_name)) > 0 &&
              contains(
                keys(local.private_link_subresources_by_resource_type),
                try(lower(join("/", slice(split("/", trimspace(var.private_service_connection.private_connection_resource_id)), 6, 8))), "")
              ) &&
              contains(
                local.private_link_subresources_by_resource_type[try(lower(join("/", slice(split("/", trimspace(var.private_service_connection.private_connection_resource_id)), 6, 8))), "")],
                lower(trimspace(cfg.subresource_name))
              ) &&
              try(var.private_service_connection.subresource_names, null) != null &&
              contains(
                [for name in var.private_service_connection.subresource_names : lower(trimspace(name))],
                lower(trimspace(cfg.subresource_name))
              )
            )
          )
        )
      ]) &&
      length(distinct([
        for cfg in var.ip_configurations : lower(trimspace(cfg.private_ip_address))
      ])) == length(var.ip_configurations) &&
      length(distinct([
        for cfg in var.ip_configurations : lower(trimspace(cfg.name)) if try(cfg.name, null) != null
        ])) == length([
        for cfg in var.ip_configurations : 1 if try(cfg.name, null) != null
      ])
    )
    error_message = "Each ip_configurations entry must include a valid IPv4 private_ip_address. If name is set, it must be non-empty and unique. If subresource_name is set, it must be non-empty, valid for the private_connection_resource_id resource type, and exist in private_service_connection.subresource_names. private_ip_address values must be unique across ip_configurations entries."
  }
}

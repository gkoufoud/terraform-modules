variable "dns_zones" {
  description = "Public DNS zones to create. Expected keys for each item: name, resource_group_name, dns_sec_enabled (optional), soa_record (optional), tags (optional)."
  type = list(object({
    name                = string
    resource_group_name = string
    zone_type           = optional(string, "public") # "public" or "private"
    dns_sec_enabled     = optional(bool, false)
    soa_record = optional(object({
      email         = optional(string, "azuredns-hostmaster.microsoft.com")
      expire_time   = optional(number, 2419200)
      minimum_ttl   = optional(number, 300)
      refresh_time  = optional(number, 3600)
      retry_time    = optional(number, 300)
      serial_number = optional(number, 1)
      ttl           = optional(number, 3600)
      tags          = optional(map(string), {})
    }), null)
    tags = optional(map(string), {})
  }))
  default = []

  validation {
    condition = alltrue([
      for zone in var.dns_zones :
      contains(["public", "private"], lower(zone.zone_type))
    ])
    error_message = "Each DNS zone 'zone_type' must be either 'public' or 'private'."
  }
}

variable "auto_subdomain_delegation" {
  description = "Whether to automatically create NS records in parent zones for subdomain delegation. Only applies to public zones. Default is true."
  type        = bool
  default     = true
}

variable "vnet_links" {
  description = "List of virtual network links to create for private DNS zones."
  type = list(object({
    name                  = string
    private_dns_zone_name = string
    resource_group_name   = string
    virtual_network_id    = string
    registration_enabled  = optional(bool, false)
    resolution_policy     = optional(string, "Default") # "Default" or "NxDomainRedirect"
    tags                  = optional(map(string), {})
  }))
  default = []
  validation {
    condition = alltrue([
      for link in var.vnet_links :
      contains(["default", "nxdomainredirect"], lower(link.resolution_policy))
    ])
    error_message = "Each virtual network link 'resolution_policy' must be either 'Default' or 'NxDomainRedirect'."
  }
  validation {
    condition = alltrue([
      for link in var.vnet_links :
      can(regex("^/subscriptions/[^/]+/resourceGroups/[^/]+/providers/Microsoft\\.Network/virtualNetworks/[^/]+$", link.virtual_network_id))
    ])
    error_message = "Each virtual network link 'virtual_network_id' must be in the format: /subscriptions/<subscription_id>/resourceGroups/<resource_group_name>/providers/Microsoft.Network/virtualNetworks/<virtual_network_name>"
  }
}

variable "a_records" {
  description = "List of A records to create. Each item should be a map with keys: name, zone_name, resource_group_name, ttl (optional), records (list of IPs), tags (optional)"
  type = list(object({
    name                = string
    zone_name           = string
    resource_group_name = string
    zone_type           = optional(string, "public") # "public" or "private"
    ttl                 = optional(number, 300)
    records             = optional(list(string), null)
    target_resource_id  = optional(string, null)
    tags                = optional(map(string), {})
  }))
  default = []
  validation {
    condition = alltrue([
      for record in var.a_records :
      (record.records != null && record.target_resource_id == null) ||
      (
        record.records == null
        && record.target_resource_id != null
        && lower(record.zone_type) != "private"
      )
    ])
    error_message = "Each A record must have either 'records' or 'target_resource_id' defined, but not both. For private zones, 'target_resource_id' must be null."
  }

  validation {
    condition = alltrue([
      for record in var.a_records :
      contains(["public", "private"], lower(record.zone_type))
    ])
    error_message = "Each A record 'zone_type' must be either 'public' or 'private'."
  }
}

variable "cname_records" {
  description = "List of CNAME records to create. Each item should be a map with keys: name, zone_name, resource_group_name, ttl (optional), record (CNAME target), tags (optional)"
  type = list(object({
    name                = string
    zone_name           = string
    resource_group_name = string
    zone_type           = optional(string, "public") # "public" or "private"
    ttl                 = optional(number, 300)
    record              = optional(string, null)
    target_resource_id  = optional(string, null)
    tags                = optional(map(string), {})
  }))
  default = []
  validation {
    condition = alltrue([
      for record in var.cname_records :
      (record.record != null && record.target_resource_id == null) ||
      (
        record.record == null
        && record.target_resource_id != null
        && lower(record.zone_type) != "private"
      )
    ])
    error_message = "Each CNAME record must have either 'record' or 'target_resource_id' defined, but not both. For private zones, 'target_resource_id' must be null."
  }
  validation {
    condition = alltrue([
      for record in var.cname_records :
      contains(["public", "private"], lower(record.zone_type))
    ])
    error_message = "Each CNAME record 'zone_type' must be either 'public' or 'private'."
  }
}

variable "mx_records" {
  description = "List of MX records to create. Each item should be a map with keys: name, zone_name, resource_group_name, ttl (optional), records (list of maps with keys 'preference' and 'exchange'), tags (optional)"
  type = list(object({
    name                = string
    zone_name           = string
    zone_type           = optional(string, "public") # "public" or "private"
    resource_group_name = string
    ttl                 = optional(number, 300)
    records = list(object({
      preference = number
      exchange   = string
    }))
    tags = optional(map(string), {})
  }))
  default = []
  validation {
    condition = alltrue([
      for record in var.mx_records :
      contains(["public", "private"], lower(record.zone_type))
    ])
    error_message = "Each MX record 'zone_type' must be either 'public' or 'private'."
  }
}

variable "ns_records" {
  description = "List of NS records to create. Each item should be a map with keys: name, zone_name, resource_group_name, ttl (optional), records (list of NS targets), tags (optional)"
  type = list(object({
    name                = string
    zone_name           = string
    resource_group_name = string
    ttl                 = optional(number, 300)
    records             = list(string)
    tags                = optional(map(string), {})
  }))
  default = []
}

variable "caa_records" {
  description = "List of CAA records to create. Each item should be a map with keys: name, zone_name, resource_group_name, ttl (optional), flags, tag, value, tags (optional)"
  type = list(object({
    name                = string
    zone_name           = string
    resource_group_name = string
    ttl                 = optional(number, 300)
    records = list(object({
      flags = number
      tag   = string
      value = string
    }))
    tags = optional(map(string), {})
  }))
  default = []

  validation {
    condition = alltrue([
      for record in var.caa_records :
      length(trimspace(record.name)) > 0
      && length(trimspace(record.zone_name)) > 0
      && length(trimspace(record.resource_group_name)) > 0
      && length(record.records) > 0
    ])
    error_message = "Each CAA record must define non-empty name, zone_name, resource_group_name, and at least one entry in records."
  }

  validation {
    condition = alltrue(flatten([
      for record in var.caa_records : [
        for caa in record.records :
        contains([0, 1], caa.flags)
      ]
    ]))
    error_message = "Each CAA records entry 'flags' must be 0 or 1."
  }

  validation {
    condition = alltrue(flatten([
      for record in var.caa_records : [
        for caa in record.records :
        contains(["issue", "issuewild", "iodef", "contactemail"], lower(caa.tag))
        && length(trimspace(caa.value)) > 0
      ]
    ]))
    error_message = "Each CAA records entry must have tag in [issue, issuewild, iodef, contactemail] and a non-empty value."
  }
}

variable "ptr_records" {
  description = "List of PTR records to create. Each item should be a map with keys: name, zone_name, resource_group_name, ttl (optional), records (list of PTR targets), tags (optional)"
  type = list(object({
    name                = string
    zone_name           = string
    resource_group_name = string
    zone_type           = optional(string, "public") # "public" or "private"
    ttl                 = optional(number, 300)
    records             = list(string)
    tags                = optional(map(string), {})
  }))
  default = []

  validation {
    condition = alltrue([
      for record in var.ptr_records :
      contains(["public", "private"], lower(record.zone_type))
    ])
    error_message = "Each PTR record 'zone_type' must be either 'public' or 'private'."
  }
}

variable "srv_records" {
  description = "List of SRV records to create. Each item should be a map with keys: name, zone_name, resource_group_name, ttl (optional), records (list of maps with keys 'priority', 'weight', 'port', 'target'), tags (optional)"
  type = list(object({
    name                = string
    zone_name           = string
    resource_group_name = string
    zone_type           = optional(string, "public") # "public" or "private"
    ttl                 = optional(number, 300)
    records = list(object({
      priority = number
      weight   = number
      port     = number
      target   = string
    }))
    tags = optional(map(string), {})
  }))
  default = []

  validation {
    condition = alltrue([
      for record in var.srv_records :
      contains(["public", "private"], lower(record.zone_type))
    ])
    error_message = "Each SRV record 'zone_type' must be either 'public' or 'private'."
  }
}

variable "txt_records" {
  description = "List of TXT records to create. Each item should be a map with keys: name, zone_name, resource_group_name, ttl (optional), records (list of TXT values), tags (optional)"
  type = list(object({
    name                = string
    zone_name           = string
    resource_group_name = string
    zone_type           = optional(string, "public") # "public" or "private"
    ttl                 = optional(number, 300)
    records             = list(string)
    tags                = optional(map(string), {})
  }))
  default = []

  validation {
    condition = alltrue([
      for record in var.txt_records :
      contains(["public", "private"], lower(record.zone_type))
    ])
    error_message = "Each TXT record 'zone_type' must be either 'public' or 'private'."
  }
}

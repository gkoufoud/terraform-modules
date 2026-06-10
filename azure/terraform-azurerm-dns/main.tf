resource "azurerm_dns_zone" "public_zone" {
  for_each            = { for zone in var.dns_zones : "${zone.resource_group_name}_${zone.name}" => zone if lower(zone.zone_type) == "public" }
  name                = each.value.name
  resource_group_name = each.value.resource_group_name
  dynamic "soa_record" {
    for_each = each.value.soa_record == null ? [] : [each.value.soa_record]
    content {
      email         = soa_record.value.email
      expire_time   = soa_record.value.expire_time
      minimum_ttl   = soa_record.value.minimum_ttl
      refresh_time  = soa_record.value.refresh_time
      retry_time    = soa_record.value.retry_time
      serial_number = soa_record.value.serial_number
      ttl           = soa_record.value.ttl
      tags          = soa_record.value.tags
    }
  }
  tags = each.value.tags
}

resource "azurerm_private_dns_zone" "private_zone" {
  for_each            = { for zone in var.dns_zones : "${zone.resource_group_name}_${zone.name}" => zone if lower(zone.zone_type) == "private" }
  name                = each.value.name
  resource_group_name = each.value.resource_group_name
  dynamic "soa_record" {
    for_each = each.value.soa_record == null ? [] : [each.value.soa_record]
    content {
      email         = soa_record.value.email
      expire_time   = soa_record.value.expire_time
      minimum_ttl   = soa_record.value.minimum_ttl
      refresh_time  = soa_record.value.refresh_time
      retry_time    = soa_record.value.retry_time
      serial_number = soa_record.value.serial_number
      ttl           = soa_record.value.ttl
      tags          = soa_record.value.tags
    }
  }
  tags = each.value.tags
}

resource "azapi_resource" "public_zone_dnssec" {
  for_each = {
    for zone in var.dns_zones :
    "${zone.resource_group_name}_${zone.name}" => zone if lower(zone.zone_type) == "public" && zone.dns_sec_enabled
  }
  type      = "Microsoft.Network/dnsZones/dnssecConfigs@2023-07-01-preview"
  name      = "default"
  parent_id = azurerm_dns_zone.public_zone[each.key].id
}

resource "azurerm_private_dns_zone_virtual_network_link" "vnet_link" {
  for_each = {
    for link in var.vnet_links : "${link.resource_group_name}_${link.private_dns_zone_name}_${link.virtual_network_id}" => link
  }
  name                  = each.value.name
  private_dns_zone_name = each.value.private_dns_zone_name
  resource_group_name   = each.value.resource_group_name
  virtual_network_id    = each.value.virtual_network_id
  registration_enabled  = each.value.registration_enabled
  resolution_policy     = each.value.resolution_policy
  tags                  = each.value.tags
  depends_on = [
    azurerm_private_dns_zone.private_zone,
  ]
}

resource "azurerm_dns_a_record" "public_a_record" {
  for_each = {
    for record in var.a_records :
    "${record.resource_group_name}-${record.zone_name}-${record.name}" => record if lower(record.zone_type) == "public"
  }
  name                = each.value.name
  zone_name           = each.value.zone_name
  resource_group_name = each.value.resource_group_name
  ttl                 = each.value.ttl
  records             = each.value.records
  target_resource_id  = each.value.target_resource_id
  tags                = each.value.tags
  depends_on = [
    azurerm_dns_zone.public_zone,
    azurerm_private_dns_zone.private_zone,
  ]
}

resource "azurerm_private_dns_a_record" "private_a_record" {
  for_each = {
    for record in var.a_records :
    "${record.resource_group_name}-${record.zone_name}-${record.name}" => record if lower(record.zone_type) == "private"
  }
  name                = each.value.name
  zone_name           = each.value.zone_name
  resource_group_name = each.value.resource_group_name
  ttl                 = each.value.ttl
  records             = each.value.records
  tags                = each.value.tags
}

resource "azurerm_dns_cname_record" "public_cname_record" {
  for_each = {
    for record in var.cname_records :
    "${record.resource_group_name}-${record.zone_name}-${record.name}" => record if lower(record.zone_type) == "public"
  }
  name                = each.value.name
  zone_name           = each.value.zone_name
  resource_group_name = each.value.resource_group_name
  ttl                 = each.value.ttl
  record              = each.value.record
  target_resource_id  = each.value.target_resource_id
  tags                = each.value.tags
}

resource "azurerm_private_dns_cname_record" "private_cname_record" {
  for_each = {
    for record in var.cname_records :
    "${record.resource_group_name}-${record.zone_name}-${record.name}" => record if lower(record.zone_type) == "private"
  }
  name                = each.value.name
  zone_name           = each.value.zone_name
  resource_group_name = each.value.resource_group_name
  ttl                 = each.value.ttl
  record              = each.value.record
  tags                = each.value.tags
}

resource "azurerm_dns_mx_record" "public_mx_record" {
  for_each = {
    for record in var.mx_records :
    "${record.resource_group_name}-${record.zone_name}-${record.name}" => record if lower(record.zone_type) == "public"
  }
  name                = each.value.name
  zone_name           = each.value.zone_name
  resource_group_name = each.value.resource_group_name
  ttl                 = each.value.ttl
  dynamic "record" {
    for_each = each.value.records
    content {
      preference = record.value.preference
      exchange   = record.value.exchange
    }
  }
  tags = each.value.tags
}

resource "azurerm_private_dns_mx_record" "private_mx_record" {
  for_each = {
    for record in var.mx_records :
    "${record.resource_group_name}-${record.zone_name}-${record.name}" => record if lower(record.zone_type) == "private"
  }
  name                = each.value.name
  zone_name           = each.value.zone_name
  resource_group_name = each.value.resource_group_name
  ttl                 = each.value.ttl
  dynamic "record" {
    for_each = each.value.records
    content {
      preference = record.value.preference
      exchange   = record.value.exchange
    }
  }
  tags = each.value.tags
}

resource "azurerm_dns_ns_record" "ns_record" {
  for_each = {
    for record in local.ns_records :
    "${record.resource_group_name}-${record.zone_name}-${record.name}" => record
  }
  name                = each.value.name
  zone_name           = each.value.zone_name
  resource_group_name = each.value.resource_group_name
  ttl                 = each.value.ttl
  records             = each.value.records
  tags                = each.value.tags
}

resource "azurerm_dns_caa_record" "caa_record" {
  for_each = {
    for record in var.caa_records :
    "${record.resource_group_name}-${record.zone_name}-${record.name}" => record
  }
  name                = each.value.name
  zone_name           = each.value.zone_name
  resource_group_name = each.value.resource_group_name
  ttl                 = each.value.ttl
  dynamic "record" {
    for_each = each.value.records
    content {
      flags = record.value.flags
      tag   = record.value.tag
      value = record.value.value
    }
  }
  tags = each.value.tags
}

resource "azurerm_dns_ptr_record" "public_ptr_record" {
  for_each = {
    for record in var.ptr_records :
    "${record.resource_group_name}-${record.zone_name}-${record.name}" => record if lower(record.zone_type) == "public"
  }
  name                = each.value.name
  zone_name           = each.value.zone_name
  resource_group_name = each.value.resource_group_name
  ttl                 = each.value.ttl
  records             = each.value.records
  tags                = each.value.tags
}

resource "azurerm_private_dns_ptr_record" "private_ptr_record" {
  for_each = {
    for record in var.ptr_records :
    "${record.resource_group_name}-${record.zone_name}-${record.name}" => record if lower(record.zone_type) == "private"
  }
  name                = each.value.name
  zone_name           = each.value.zone_name
  resource_group_name = each.value.resource_group_name
  ttl                 = each.value.ttl
  records             = each.value.records
  tags                = each.value.tags
}

resource "azurerm_dns_srv_record" "public_srv_record" {
  for_each = {
    for record in var.srv_records :
    "${record.resource_group_name}-${record.zone_name}-${record.name}" => record if lower(record.zone_type) == "public"
  }
  name                = each.value.name
  zone_name           = each.value.zone_name
  resource_group_name = each.value.resource_group_name
  ttl                 = each.value.ttl
  dynamic "record" {
    for_each = each.value.records
    content {
      priority = record.value.priority
      weight   = record.value.weight
      port     = record.value.port
      target   = record.value.target
    }
  }
  tags = each.value.tags
}

resource "azurerm_private_dns_srv_record" "private_srv_record" {
  for_each = {
    for record in var.srv_records :
    "${record.resource_group_name}-${record.zone_name}-${record.name}" => record if lower(record.zone_type) == "private"
  }
  name                = each.value.name
  zone_name           = each.value.zone_name
  resource_group_name = each.value.resource_group_name
  ttl                 = each.value.ttl
  dynamic "record" {
    for_each = each.value.records
    content {
      priority = record.value.priority
      weight   = record.value.weight
      port     = record.value.port
      target   = record.value.target
    }
  }
  tags = each.value.tags
}

resource "azurerm_dns_txt_record" "public_txt_record" {
  for_each = {
    for record in var.txt_records :
    "${record.resource_group_name}-${record.zone_name}-${record.name}" => record if lower(record.zone_type) == "public"
  }
  name                = each.value.name
  zone_name           = each.value.zone_name
  resource_group_name = each.value.resource_group_name
  ttl                 = each.value.ttl
  dynamic "record" {
    for_each = each.value.records
    content {
      value = record.value
    }
  }
  tags = each.value.tags
}

resource "azurerm_private_dns_txt_record" "private_txt_record" {
  for_each = {
    for record in var.txt_records :
    "${record.resource_group_name}-${record.zone_name}-${record.name}" => record if lower(record.zone_type) == "private"
  }
  name                = each.value.name
  zone_name           = each.value.zone_name
  resource_group_name = each.value.resource_group_name
  ttl                 = each.value.ttl
  dynamic "record" {
    for_each = each.value.records
    content {
      value = record.value
    }
  }
  tags = each.value.tags
}


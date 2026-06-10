locals {
  zone_names = toset([for zone in var.dns_zones : zone.name])

  zones_by_name = {
    for zone in var.dns_zones :
    zone.name => zone
  }

  parent_zone_candidates = {
    for zone in var.dns_zones :
    zone.name => join(".", slice(split(".", zone.name), 1, length(split(".", zone.name))))
    if length(split(".", zone.name)) > 1
  }

  parent_zones = {
    for zone_name, parent_zone_name in local.parent_zone_candidates :
    "${local.zones_by_name[zone_name].resource_group_name}/${zone_name}" => "${local.zones_by_name[parent_zone_name].resource_group_name}/${parent_zone_name}"
    if contains(local.zone_names, parent_zone_name)
  }

  subdomain_delegation_records = [
    for zone_name, parent_zone in local.parent_zones :
    {
      name                = split(".", zone_name)[0]
      zone_name           = split("/", parent_zone)[1]
      resource_group_name = split("/", parent_zone)[0]
      ttl                 = 3600
      records             = azurerm_dns_zone.public_zone["${split("/", parent_zone)[0]}_${split("/", parent_zone)[1]}"].name_servers
      tags                = {}
    }
  ]

  ns_records = var.auto_subdomain_delegation ? concat(var.ns_records, local.subdomain_delegation_records) : var.ns_records

}

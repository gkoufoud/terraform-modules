resource "azurerm_private_endpoint" "pe" {
  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location
  tags                = var.tags

  subnet_id = var.subnet_id

  custom_network_interface_name = var.custom_network_interface_name

  dynamic "private_dns_zone_group" {
    for_each = var.private_dns_zone_group == null ? [] : [var.private_dns_zone_group]
    content {
      name                 = private_dns_zone_group.value.name
      private_dns_zone_ids = private_dns_zone_group.value.private_dns_zone_ids
    }
  }

  private_service_connection {
    name                              = var.private_service_connection.name
    is_manual_connection              = var.private_service_connection.is_manual_connection
    private_connection_resource_id    = var.private_service_connection.private_connection_resource_id
    private_connection_resource_alias = var.private_service_connection.private_connection_resource_alias
    subresource_names                 = var.private_service_connection.subresource_names
    request_message                   = var.private_service_connection.request_message
  }

  dynamic "ip_configuration" {
    for_each = { for idx, cfg in var.ip_configurations : tostring(idx) => cfg }
    content {
      name               = coalesce(try(ip_configuration.value.name, null), format("%s-ipconfig-%s", var.name, ip_configuration.key))
      private_ip_address = ip_configuration.value.private_ip_address
      subresource_name   = try(ip_configuration.value.subresource_name, null)
    }
  }
}

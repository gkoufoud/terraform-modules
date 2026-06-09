mock_provider "azurerm" {
  override_during = plan
}

run "test_private_endpoint_custom_interface_name" {

  module {
    source = "../../azure/terraform-azurerm-private-endpoint"
  }

  override_resource {
    target = azurerm_private_endpoint.pe
    values = {
      id = "test-pe-id"
      private_service_connection = {
        private_ip_address = "10.0.0.4"
      }
    }
  }

  variables {
    name                          = "example-private-endpoint"
    resource_group_name           = "example-resource-group"
    location                      = "uksouth"
    custom_network_interface_name = "example-nic"
    subnet_id                     = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/example-resource-group/providers/Microsoft.Network/virtualNetworks/example-vnet/subnets/example-subnet"
    private_service_connection = {
      name                           = "example-psc"
      private_connection_resource_id = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/example-resource-group/providers/Microsoft.Sql/servers/example-sql-server"
      subresource_names              = ["sqlServer"]
    }
    tags = {
      environment = "prod"
    }
  }

  assert {
    condition = jsonencode(output.private_endpoint) == jsonencode({
      custom_network_interface_name = "example-nic"
      custom_dns_configs            = []
      id                            = "test-pe-id"
      ip_configuration              = []
      location                      = "uksouth"
      name                          = "example-private-endpoint"
      network_interface             = []
      private_dns_zone_configs      = []
      private_dns_zone_group        = []
      private_service_connection = [
        {
          is_manual_connection              = false
          name                              = "example-psc"
          private_connection_resource_alias = null
          private_connection_resource_id    = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/example-resource-group/providers/Microsoft.Sql/servers/example-sql-server"
          private_ip_address                = "10.0.0.4"
          request_message                   = null
          subresource_names = [
            "sqlServer",
          ]
        },
      ]
      resource_group_name = "example-resource-group"
      subnet_id           = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/example-resource-group/providers/Microsoft.Network/virtualNetworks/example-vnet/subnets/example-subnet"
      tags = {
        "environment" = "prod"
      }
      timeouts = null
    })
    error_message = "bad values"
  }
}

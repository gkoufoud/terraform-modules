mock_provider "azurerm" {
  override_during = plan
}

run "test_private_endpoint_fail_name" {

  command = plan
  module {
    source = "../../azure/terraform-azurerm-private-endpoint"
  }

  variables {
    name                = "e"
    resource_group_name = "example-resource-group"
    location            = "uksouth"
    subnet_id           = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/example-resource-group/providers/Microsoft.Network/virtualNetworks/example-vnet/subnets/example-subnet"
    private_service_connection = {
      name                           = "example-psc"
      private_connection_resource_id = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/example-resource-group/providers/Microsoft.Sql/servers/example-sql-server"
      subresource_names              = ["sqlServer"]
    }
    tags = {
      environment = "prod"
    }
  }

  expect_failures = [
    var.name,
  ]
}

run "test_private_endpoint_fail_subnet_id" {

  command = plan
  module {
    source = "../../azure/terraform-azurerm-private-endpoint"
  }

  variables {
    name                = "example-private-endpoint"
    resource_group_name = "example-resource-group"
    location            = "uksouth"
    subnet_id           = "invalid-subnet"
    private_service_connection = {
      name                           = "example-psc"
      private_connection_resource_id = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/example-resource-group/providers/Microsoft.Sql/servers/example-sql-server"
      subresource_names              = ["sqlServer"]
    }
    tags = {
      environment = "prod"
    }
  }

  expect_failures = [
    var.subnet_id,
  ]
}

run "test_private_endpoint_fail_dns_zone_group_name" {

  command = plan
  module {
    source = "../../azure/terraform-azurerm-private-endpoint"
  }

  variables {
    name                = "example-private-endpoint"
    resource_group_name = "example-resource-group"
    location            = "uksouth"
    subnet_id           = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/example-resource-group/providers/Microsoft.Network/virtualNetworks/example-vnet/subnets/example-subnet"
    private_dns_zone_group = {
      name = "exa"
      private_dns_zone_ids = [
        "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/example-resource-group/providers/Microsoft.Network/privateDnsZones/example.com"
      ]
    }
    private_service_connection = {
      name                           = "example-psc"
      private_connection_resource_id = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/example-resource-group/providers/Microsoft.Sql/servers/example-sql-server"
      subresource_names              = ["sqlServer"]
    }
    tags = {
      environment = "prod"
    }
  }

  expect_failures = [
    var.private_dns_zone_group,
  ]
}

run "test_private_endpoint_fail_dns_zone_group_zone_ids_empty" {

  command = plan
  module {
    source = "../../azure/terraform-azurerm-private-endpoint"
  }

  variables {
    name                = "example-private-endpoint"
    resource_group_name = "example-resource-group"
    location            = "uksouth"
    subnet_id           = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/example-resource-group/providers/Microsoft.Network/virtualNetworks/example-vnet/subnets/example-subnet"
    private_dns_zone_group = {
      name                 = "example-dns-zone-group"
      private_dns_zone_ids = []
    }
    private_service_connection = {
      name                           = "example-psc"
      private_connection_resource_id = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/example-resource-group/providers/Microsoft.Sql/servers/example-sql-server"
      subresource_names              = ["sqlServer"]
    }
    tags = {
      environment = "prod"
    }
  }

  expect_failures = [
    var.private_dns_zone_group,
  ]
}

run "test_private_endpoint_fail_dns_zone_group_zone_ids_invalid" {

  command = plan
  module {
    source = "../../azure/terraform-azurerm-private-endpoint"
  }

  variables {
    name                = "example-private-endpoint"
    resource_group_name = "example-resource-group"
    location            = "uksouth"
    subnet_id           = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/example-resource-group/providers/Microsoft.Network/virtualNetworks/example-vnet/subnets/example-subnet"
    private_dns_zone_group = {
      name                 = "example-dns-zone-group"
      private_dns_zone_ids = ["invalid-zone-id"]
    }
    private_service_connection = {
      name                           = "example-psc"
      private_connection_resource_id = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/example-resource-group/providers/Microsoft.Sql/servers/example-sql-server"
      subresource_names              = ["sqlServer"]
    }
    tags = {
      environment = "prod"
    }
  }

  expect_failures = [
    var.private_dns_zone_group,
  ]
}

run "test_private_endpoint_fail_private_service_connection_name" {

  command = plan
  module {
    source = "../../azure/terraform-azurerm-private-endpoint"
  }

  variables {
    name                = "example-private-endpoint"
    resource_group_name = "example-resource-group"
    location            = "uksouth"
    subnet_id           = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/example-resource-group/providers/Microsoft.Network/virtualNetworks/example-vnet/subnets/example-subnet"
    private_service_connection = {
      name                           = "exa"
      private_connection_resource_id = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/example-resource-group/providers/Microsoft.Sql/servers/example-sql-server"
      subresource_names              = ["sqlServer"]
    }
    tags = {
      environment = "prod"
    }
  }

  expect_failures = [
    var.private_service_connection,
  ]
}


run "test_private_endpoint_fail_private_service_connection_private_connection_resource_id" {

  command = plan
  module {
    source = "../../azure/terraform-azurerm-private-endpoint"
  }

  variables {
    name                = "example-private-endpoint"
    resource_group_name = "example-resource-group"
    location            = "uksouth"
    subnet_id           = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/example-resource-group/providers/Microsoft.Network/virtualNetworks/example-vnet/subnets/example-subnet"
    private_service_connection = {
      name                           = "example-psc"
      private_connection_resource_id = "invalid-resource-id"
      subresource_names              = ["sqlServer"]
    }
    tags = {
      environment = "prod"
    }
  }

  expect_failures = [
    var.private_service_connection,
  ]
}

run "test_private_endpoint_fail_private_service_connection_subresource_names" {

  command = plan
  module {
    source = "../../azure/terraform-azurerm-private-endpoint"
  }

  variables {
    name                = "example-private-endpoint"
    resource_group_name = "example-resource-group"
    location            = "uksouth"
    subnet_id           = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/example-resource-group/providers/Microsoft.Network/virtualNetworks/example-vnet/subnets/example-subnet"
    private_service_connection = {
      name                           = "example-psc"
      private_connection_resource_id = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/example-resource-group/providers/Microsoft.Sql/servers/example-sql-server"
      subresource_names              = ["invalid-subresource"]
    }
    tags = {
      environment = "prod"
    }
  }

  expect_failures = [
    var.private_service_connection,
  ]
}

run "test_private_endpoint_fail_request_message" {

  command = plan
  module {
    source = "../../azure/terraform-azurerm-private-endpoint"
  }

  variables {
    name                = "example-private-endpoint"
    resource_group_name = "example-resource-group"
    location            = "uksouth"
    subnet_id           = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/example-resource-group/providers/Microsoft.Network/virtualNetworks/example-vnet/subnets/example-subnet"
    private_service_connection = {
      name                           = "example-psc"
      private_connection_resource_id = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/example-resource-group/providers/Microsoft.Sql/servers/example-sql-server"
      subresource_names              = ["sqlServer"]
      is_manual_connection           = true
      request_message                = join("", [for i in range(141) : "a"])
    }
    tags = {
      environment = "prod"
    }
  }

  expect_failures = [
    var.private_service_connection,
  ]
}

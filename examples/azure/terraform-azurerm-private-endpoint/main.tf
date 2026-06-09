variable "aks_cluster" { # format: resourcegroup/clustername
  type        = string
  description = "The resource group and name of the AKS cluster to create a federated identity credential for. Format: resourcegroup/clustername."
  validation {
    condition     = var.aks_cluster == "" || length(split("/", var.aks_cluster)) == 2
    error_message = "aks_cluster must be in the format resourcegroup/clustername."
  }
  default = ""
}

module "private_endpoint_simple" {
  source              = "git::https://github.com/gkoufoud/terraform-modules.git//azure/terraform-azurerm-private-endpoint"
  name                = "example-private-endpoint1"
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

module "private_endpoint_custom_interface_name" {
  source                        = "git::https://github.com/gkoufoud/terraform-modules.git//azure/terraform-azurerm-private-endpoint"
  name                          = "example-private-endpoint2"
  resource_group_name           = "example-resource-group"
  location                      = "uksouth"
  subnet_id                     = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/example-resource-group/providers/Microsoft.Network/virtualNetworks/example-vnet/subnets/example-subnet"
  custom_network_interface_name = "example-nic"
  private_service_connection = {
    name                           = "example-psc"
    private_connection_resource_id = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/example-resource-group/providers/Microsoft.Sql/servers/example-sql-server"
    subresource_names              = ["sqlServer"]
  }
  tags = {
    environment = "prod"
  }
}

module "private_endpoint_ip_configuration" {
  source              = "git::https://github.com/gkoufoud/terraform-modules.git//azure/terraform-azurerm-private-endpoint"
  name                = "example-private-endpoint3"
  resource_group_name = "example-resource-group"
  location            = "uksouth"
  subnet_id           = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/example-resource-group/providers/Microsoft.Network/virtualNetworks/example-vnet/subnets/example-subnet"
  private_service_connection = {
    name                           = "example-psc"
    private_connection_resource_id = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/example-resource-group/providers/Microsoft.Sql/servers/example-sql-server"
    subresource_names              = ["sqlServer"]
  }
  ip_configurations = [
    {
      private_ip_address = "10.0.0.4"
    }
  ]
  tags = {
    environment = "prod"
  }
}

module "private_endpoint_private_dns_zone_group" {
  source              = "git::https://github.com/gkoufoud/terraform-modules.git//azure/terraform-azurerm-private-endpoint"
  name                = "example-private-endpoint4"
  resource_group_name = "example-resource-group"
  location            = "uksouth"
  subnet_id           = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/example-resource-group/providers/Microsoft.Network/virtualNetworks/example-vnet/subnets/example-subnet"
  private_service_connection = {
    name                           = "example-psc"
    private_connection_resource_id = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/example-resource-group/providers/Microsoft.Sql/servers/example-sql-server"
    subresource_names              = ["sqlServer"]
  }
  private_dns_zone_group = {
    name = "example-dns-zone-group"
    private_dns_zone_ids = [
      "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/example-resource-group/providers/Microsoft.Network/privateDnsZones/example.com"
    ]
  }
  tags = {
    environment = "prod"
  }
}

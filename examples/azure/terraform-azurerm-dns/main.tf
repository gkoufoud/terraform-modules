module "dns_example" {
  source = "git::https://github.com/gkoufoud/terraform-modules.git//azure/terraform-azurerm-dns"
  dns_zones = [
    {
      name                = "myzone.com"
      resource_group_name = "myresourcegroup"
    },
    {
      name                = "myprivatezone1.com"
      resource_group_name = "myresourcegroup"
      zone_type           = "private"
    },
    {
      name                = "myprivatezone2.com"
      resource_group_name = "myresourcegroup"
      zone_type           = "private"
    }
  ]
  vnet_links = [
    {
      name                  = "myvnetlink1"
      resource_group_name   = "myresourcegroup"
      private_dns_zone_name = "myprivatezone1.com"
      registration_enabled  = true
      virtual_network_id    = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/myresourcegroup/providers/Microsoft.Network/virtualNetworks/myvnet"
    },
    {
      name                  = "myvnetlink2"
      resource_group_name   = "myresourcegroup"
      private_dns_zone_name = "myprivatezone2.com"
      resolution_policy     = "NxDomainRedirect"
      virtual_network_id    = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/myresourcegroup/providers/Microsoft.Network/virtualNetworks/myvnet"
    }
  ]
  caa_records = [
    {
      name                = "@"
      zone_name           = "myzone.com"
      resource_group_name = "myresourcegroup"
      records = [
        {
          flags = 0
          tag   = "issue"
          value = "letsencrypt.org"
        },
        {
          flags = 0
          tag   = "issuewild"
          value = "letsencrypt.org"
        },
        {
          flags = 0
          tag   = "iodef"
          value = "admin@company.com"
        },
        {
          flags = 0
          tag   = "issue"
          value = "pki.goog"
        }
      ]
    },
  ]
  a_records = [
    {
      name                = "www"
      zone_name           = "myzone.com"
      resource_group_name = "myresourcegroup"
      records             = ["1.2.3.4", "5.6.7.8"]
    },
    {
      name                = "www"
      zone_name           = "myprivatezone1.com"
      resource_group_name = "myresourcegroup"
      zone_type           = "private"
      records             = ["2.3.4.5", "6.7.8.9"]
    }
  ]
}

module "dns_example_subdomain" {
  source = "git::https://github.com/gkoufoud/terraform-modules.git//azure/terraform-azurerm-dns"
  dns_zones = [
    {
      name                = "myzone2.com"
      resource_group_name = "myresourcegroup"
    },
    {
      name                = "subdomain.myzone2.com"
      resource_group_name = "myresourcegroup"
      zone_type           = "public"
    }
  ]
  ns_records = [
    {
      name                = "subdomain"
      zone_name           = "myzone2.com"
      resource_group_name = "myresourcegroup"
      records             = module.dns_example_subdomain.public_dns_zones["myresourcegroup_subdomain.myzone2.com"].name_servers
    }
  ]
}
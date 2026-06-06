mock_provider "azurerm" {
  override_during = plan
  # alias = "azurerm_mock"
}

#################################
override_resource {
  target = azurerm_dns_zone.public_zone["myresourcegroup_myzone.com"]
  values = {
    id = "myresourcegroup_myzone.com"
  }
}

override_resource {
  target = azurerm_dns_zone.public_zone["myresourcegroup2_myzone2.com"]
  values = {
    id = "myresourcegroup2_myzone2.com"
    soa_record = {
      fqdn      = "myzone2.com"
      host_name = "myzone2.com"
    }
  }
}

override_resource {
  target = azurerm_private_dns_zone.private_zone["myresourcegroup1_myprivatezone1.com"]
  values = {
    id = "myresourcegroup1_myprivatezone1.com"
  }
}

override_resource {
  target = azurerm_private_dns_zone.private_zone["myresourcegroup2_myprivatezone2.com"]
  values = {
    id = "myresourcegroup2_myprivatezone2.com"
  }
}
#################################
override_resource {
  target = azurerm_dns_caa_record.caa_record["myresourcegroup-myzone.com-@"]
  values = {
    id   = "myresourcegroup-myzone.com-@"
    fqdn = "@.myzone.com"
  }
}

override_resource {
  target = azurerm_dns_caa_record.caa_record["myresourcegroup2-myzone2.com-@"]
  values = {
    id   = "myresourcegroup2-myzone2.com-@"
    fqdn = "@.myzone2.com"
  }
}
#################################
override_resource {
  target = azurerm_private_dns_zone_virtual_network_link.vnet_link["myresourcegroup1_myprivatezone1.com_/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/myresourcegroup1/providers/Microsoft.Network/virtualNetworks/myvnet1"]
  values = {
    id = "id1"
  }
}

override_resource {
  target = azurerm_private_dns_zone_virtual_network_link.vnet_link["myresourcegroup2_myprivatezone2.com_/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/myresourcegroup2/providers/Microsoft.Network/virtualNetworks/myvnet2"]
  values = {
    id = "id2"
  }
}
#################################
override_resource {
  target = azurerm_dns_a_record.public_a_record["myresourcegroup1-myzone1.com-host1"]
  values = {
    id   = "id1"
    fqdn = "host1.myzone1.com"
  }
}

override_resource {
  target = azurerm_dns_a_record.public_a_record["myresourcegroup1-myzone1.com-host2"]
  values = {
    id   = "id2"
    fqdn = "host2.myzone1.com"
  }
}

override_resource {
  target = azurerm_dns_a_record.public_a_record["myresourcegroup1-myzone1.com-host3"]
  values = {
    id   = "id3"
    fqdn = "host3.myzone1.com"
  }
}

override_resource {
  target = azurerm_private_dns_a_record.private_a_record["myresourcegroup2-myprivatezone2.com-host5"]
  values = {
    id   = "id5"
    fqdn = "host5.myprivatezone2.com"
  }
}
#################################
override_resource {
  target = azurerm_dns_cname_record.public_cname_record["myresourcegroup1-myzone1.com-host1"]
  values = {
    id   = "id1"
    fqdn = "host1.myzone1.com"
  }
}

override_resource {
  target = azurerm_dns_cname_record.public_cname_record["myresourcegroup1-myzone1.com-host2"]
  values = {
    id   = "id2"
    fqdn = "host2.myzone1.com"
  }
}

override_resource {
  target = azurerm_dns_cname_record.public_cname_record["myresourcegroup1-myzone1.com-host3"]
  values = {
    id   = "id3"
    fqdn = "host3.myzone1.com"
  }
}

override_resource {
  target = azurerm_private_dns_cname_record.private_cname_record["myresourcegroup2-myprivatezone2.com-host5"]
  values = {
    id   = "id5"
    fqdn = "host5.myprivatezone2.com"
  }
}
#################################
override_resource {
  target = azurerm_dns_mx_record.public_mx_record["myresourcegroup1-myzone1.com-host1"]
  values = {
    id   = "id1"
    fqdn = "host1.myzone1.com"
  }
}
override_resource {
  target = azurerm_dns_mx_record.public_mx_record["myresourcegroup1-myzone1.com-host2"]
  values = {
    id   = "id2"
    fqdn = "host2.myzone1.com"
  }
}
override_resource {
  target = azurerm_private_dns_mx_record.private_mx_record["myresourcegroup2-myprivatezone2.com-host5"]
  values = {
    id   = "id5"
    fqdn = "host5.myprivatezone2.com"
  }
}
#################################
override_resource {
  target = azurerm_dns_ns_record.ns_record["myresourcegroup1-myzone1.com-host1"]
  values = {
    id   = "id1"
    fqdn = "host1.myzone1.com"
  }
}

override_resource {
  target = azurerm_dns_ns_record.ns_record["myresourcegroup1-myzone1.com-host2"]
  values = {
    id   = "id2"
    fqdn = "host2.myzone1.com"
  }
}
#################################
override_resource {
  target = azurerm_dns_ptr_record.public_ptr_record["myresourcegroup1-myzone1.com-host1"]
  values = {
    id   = "id1"
    fqdn = "host1.myzone1.com"
  }
}

override_resource {
  target = azurerm_dns_ptr_record.public_ptr_record["myresourcegroup1-myzone1.com-host2"]
  values = {
    id   = "id2"
    fqdn = "host2.myzone1.com"
  }
}

override_resource {
  target = azurerm_private_dns_ptr_record.private_ptr_record["myresourcegroup2-myprivatezone2.com-host5"]
  values = {
    id   = "id5"
    fqdn = "host5.myprivatezone2.com"
  }
}
#################################
override_resource {
  target = azurerm_dns_srv_record.public_srv_record["myresourcegroup1-myzone1.com-host1"]
  values = {
    id   = "id1"
    fqdn = "host1.myzone1.com"
  }
}

override_resource {
  target = azurerm_dns_srv_record.public_srv_record["myresourcegroup1-myzone1.com-host2"]
  values = {
    id   = "id2"
    fqdn = "host2.myzone1.com"
  }
}

override_resource {
  target = azurerm_private_dns_srv_record.private_srv_record["myresourcegroup2-myprivatezone2.com-host5"]
  values = {
    id   = "id5"
    fqdn = "host5.myprivatezone2.com"
  }
}
#################################
override_resource {
  target = azurerm_dns_txt_record.public_txt_record["myresourcegroup1-myzone1.com-host1"]
  values = {
    id   = "id1"
    fqdn = "host1.myzone1.com"
  }
}

override_resource {
  target = azurerm_dns_txt_record.public_txt_record["myresourcegroup1-myzone1.com-host2"]
  values = {
    id   = "id2"
    fqdn = "host2.myzone1.com"
  }
}

override_resource {
  target = azurerm_private_dns_txt_record.private_txt_record["myresourcegroup2-myprivatezone2.com-host5"]
  values = {
    id   = "id5"
    fqdn = "host5.myprivatezone2.com"
  }
}


run "test_zones" {
  variables {
    dns_zones = [
      {
        name                = "myzone.com"
        resource_group_name = "myresourcegroup"
      },
      {
        name                = "myzone2.com"
        resource_group_name = "myresourcegroup2"
        soa_record = {
          ttl           = 7200
          email         = "admin.myzone2.com"
          expire_time   = 3600
          refresh_time  = 1800
          retry_time    = 600
          minimum_ttl   = 200
          serial_number = 2026010100
          tags = {
            environment = "test"
          }
        }
      },
      {
        name                = "myprivatezone1.com"
        resource_group_name = "myresourcegroup1"
        zone_type           = "private"
      },
      {
        name                = "myprivatezone2.com"
        resource_group_name = "myresourcegroup2"
        zone_type           = "private"
      }
    ]
  }

  module {
    source = "../../azure/terraform-azurerm-dns"
  }

  assert {
    condition = jsonencode(output.private_dns_zones) == jsonencode({
      "myresourcegroup1_myprivatezone1.com" = {
        id                                                    = "myresourcegroup1_myprivatezone1.com"
        max_number_of_record_sets                             = 0
        max_number_of_virtual_network_links                   = 0
        max_number_of_virtual_network_links_with_registration = 0
        name                                                  = "myprivatezone1.com"
        number_of_record_sets                                 = 0
        resource_group_name                                   = "myresourcegroup1"
        soa_record                                            = []
        tags                                                  = {}
        timeouts                                              = null
      }
      "myresourcegroup2_myprivatezone2.com" = {
        id                                                    = "myresourcegroup2_myprivatezone2.com"
        max_number_of_record_sets                             = 0
        max_number_of_virtual_network_links                   = 0
        max_number_of_virtual_network_links_with_registration = 0
        name                                                  = "myprivatezone2.com"
        number_of_record_sets                                 = 0
        resource_group_name                                   = "myresourcegroup2"
        soa_record                                            = []
        tags                                                  = {}
        timeouts                                              = null
      }
    })
    error_message = "bad values"
  }
  assert {
    condition = jsonencode(output.public_dns_zones) == jsonencode({
      "myresourcegroup_myzone.com" = {
        id                        = "myresourcegroup_myzone.com"
        max_number_of_record_sets = 0
        name                      = "myzone.com"
        name_servers              = []
        number_of_record_sets     = 0
        resource_group_name       = "myresourcegroup"
        soa_record                = []
        tags                      = {}
        timeouts                  = null
      }
      "myresourcegroup2_myzone2.com" = {
        id                        = "myresourcegroup2_myzone2.com"
        max_number_of_record_sets = 0
        name                      = "myzone2.com"
        name_servers              = []
        number_of_record_sets     = 0
        resource_group_name       = "myresourcegroup2"
        soa_record = [
          {
            email         = "admin.myzone2.com"
            expire_time   = 3600
            fqdn          = "myzone2.com"
            host_name     = "myzone2.com"
            minimum_ttl   = 200
            refresh_time  = 1800
            retry_time    = 600
            serial_number = 2026010100
            tags = {
              "environment" = "test"
            }
            ttl = 7200
          },
        ]
        tags     = {}
        timeouts = null
      }
    })
    error_message = "bad values"
  }
}

run "caa_records" {
  variables {
    caa_records = [
      {
        name                = "@"
        zone_name           = "myzone.com"
        resource_group_name = "myresourcegroup"
        ttl                 = 3600
        records = [
          {
            flags = 0
            tag   = "issue"
            value = "ca.contoso.com"
          },
          {
            flags = 0
            tag   = "issuewild"
            value = "ca2.contoso.com"
          },
        ]
      },
      {
        name                = "@"
        zone_name           = "myzone2.com"
        resource_group_name = "myresourcegroup2"
        ttl                 = 3600
        records = [
          {
            flags = 0
            tag   = "issue"
            value = "ca.contoso.com"
          }
        ]
      }
    ]
  }

  module {
    source = "../../azure/terraform-azurerm-dns"
  }

  assert {
    condition = jsonencode(output.caa_records) == jsonencode({
      "myresourcegroup-myzone.com-@" = {
        fqdn = "@.myzone.com"
        id   = "myresourcegroup-myzone.com-@"
        name = "@"
        record = [
          {
            flags = 0
            tag   = "issue"
            value = "ca.contoso.com"
          },
          {
            flags = 0
            tag   = "issuewild"
            value = "ca2.contoso.com"
          },
        ]
        resource_group_name = "myresourcegroup"
        tags                = {}
        timeouts            = null
        ttl                 = 3600
        zone_name           = "myzone.com"
      }
      "myresourcegroup2-myzone2.com-@" = {
        fqdn = "@.myzone2.com"
        id   = "myresourcegroup2-myzone2.com-@"
        name = "@"
        record = [
          {
            flags = 0
            tag   = "issue"
            value = "ca.contoso.com"
          },
        ]
        resource_group_name = "myresourcegroup2"
        tags                = {}
        timeouts            = null
        ttl                 = 3600
        zone_name           = "myzone2.com"
      }
    })
    error_message = "bad values"
  }
}

run "test_vnet_links" {
  variables {
    vnet_links = [
      {
        name                  = "myvnetlink1"
        private_dns_zone_name = "myprivatezone1.com"
        resource_group_name   = "myresourcegroup1"
        virtual_network_id    = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/myresourcegroup1/providers/Microsoft.Network/virtualNetworks/myvnet1"
      },
      {
        name                  = "myvnetlink2"
        private_dns_zone_name = "myprivatezone2.com"
        resource_group_name   = "myresourcegroup2"
        virtual_network_id    = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/myresourcegroup2/providers/Microsoft.Network/virtualNetworks/myvnet2"
        registration_enabled  = true
        resolution_policy     = "NxDomainRedirect"
        tags = {
          environment = "test"
        }
      }
    ]
  }

  module {
    source = "../../azure/terraform-azurerm-dns"
  }

  assert {
    condition = jsonencode(output.vnet_links) == jsonencode({
      "myresourcegroup1_myprivatezone1.com_/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/myresourcegroup1/providers/Microsoft.Network/virtualNetworks/myvnet1" = {
        id                    = "id1"
        name                  = "myvnetlink1"
        private_dns_zone_name = "myprivatezone1.com"
        registration_enabled  = false
        resolution_policy     = "Default"
        resource_group_name   = "myresourcegroup1"
        tags                  = {}
        timeouts              = null
        virtual_network_id    = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/myresourcegroup1/providers/Microsoft.Network/virtualNetworks/myvnet1"
      }
      "myresourcegroup2_myprivatezone2.com_/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/myresourcegroup2/providers/Microsoft.Network/virtualNetworks/myvnet2" = {
        id                    = "id2"
        name                  = "myvnetlink2"
        private_dns_zone_name = "myprivatezone2.com"
        registration_enabled  = true
        resolution_policy     = "NxDomainRedirect"
        resource_group_name   = "myresourcegroup2"
        tags = {
          "environment" = "test"
        }
        timeouts           = null
        virtual_network_id = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/myresourcegroup2/providers/Microsoft.Network/virtualNetworks/myvnet2"
      }
    })
    error_message = "bad values"
  }
}


run "test_a_records" {
  variables {
    a_records = [
      {
        name                = "host1"
        zone_name           = "myzone1.com"
        resource_group_name = "myresourcegroup1"
        records             = ["1.2.3.4"]
      },
      {
        name                = "host2"
        zone_name           = "myzone1.com"
        resource_group_name = "myresourcegroup1"
        records             = ["5.6.7.8", "51.62.71.81"]
        tags = {
          environment = "test"
        }
      },
      {
        name                = "host3"
        zone_name           = "myzone1.com"
        resource_group_name = "myresourcegroup1"
        target_resource_id  = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/myresourcegroup1/providers/Microsoft.Network/publicIPAddresses/mypublicip1"
        tags = {
          environment = "test"
          usage       = "host3"
        }
      },
      {
        name                = "host5"
        zone_name           = "myprivatezone2.com"
        resource_group_name = "myresourcegroup2"
        zone_type           = "private"
        records             = ["10.10.10.5"]
        ttl                 = 7200
      },
    ]
  }

  module {
    source = "../../azure/terraform-azurerm-dns"
  }

  assert {
    condition = jsonencode(output.public_a_records) == jsonencode({
      "myresourcegroup1-myzone1.com-host1" = {
        fqdn = "host1.myzone1.com"
        id   = "id1"
        name = "host1"
        records = [
          "1.2.3.4",
        ]
        resource_group_name = "myresourcegroup1"
        tags                = {}
        target_resource_id  = null
        timeouts            = null
        ttl                 = 300
        zone_name           = "myzone1.com"
      }
      "myresourcegroup1-myzone1.com-host2" = {
        fqdn = "host2.myzone1.com"
        id   = "id2"
        name = "host2"
        records = [
          "5.6.7.8",
          "51.62.71.81",
        ]
        resource_group_name = "myresourcegroup1"
        tags = {
          "environment" = "test"
        }
        target_resource_id = null
        timeouts           = null
        ttl                = 300
        zone_name          = "myzone1.com"
      }
      "myresourcegroup1-myzone1.com-host3" = {
        fqdn                = "host3.myzone1.com"
        id                  = "id3"
        name                = "host3"
        records             = null
        resource_group_name = "myresourcegroup1"
        tags = {
          "environment" = "test"
          "usage"       = "host3"
        }
        target_resource_id = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/myresourcegroup1/providers/Microsoft.Network/publicIPAddresses/mypublicip1"
        timeouts           = null
        ttl                = 300
        zone_name          = "myzone1.com"
      }
    })
    error_message = "bad values"
  }

  assert {
    condition = jsonencode(output.private_a_records) == jsonencode({
      "myresourcegroup2-myprivatezone2.com-host5" = {
          fqdn                = "host5.myprivatezone2.com"
          id                  = "id5"
          name                = "host5"
          records             = [
              "10.10.10.5",
          ]
          resource_group_name = "myresourcegroup2"
          tags                = {}
          timeouts            = null
          ttl                 = 7200
          zone_name           = "myprivatezone2.com"
      }
    })
    error_message = "bad values"

  }
}

run "test_cname_records" {
  variables {
    cname_records = [
      {
        name                = "host1"
        zone_name           = "myzone1.com"
        resource_group_name = "myresourcegroup1"
        record              = "mytarget1.contoso.com"
      },
      {
        name                = "host2"
        zone_name           = "myzone1.com"
        resource_group_name = "myresourcegroup1"
        record              = "mytarget2.contoso.com"
        tags = {
          environment = "test"
        }
        ttl = 3600
      },
      {
        name                = "host3"
        zone_name           = "myzone1.com"
        resource_group_name = "myresourcegroup1"
        target_resource_id  = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/myresourcegroup1/providers/Microsoft.Network/publicIPAddresses/mypublicip1"
        tags = {
          environment = "test"
          usage       = "host3"
        }
      },
      {
        name                = "host5"
        zone_name           = "myprivatezone2.com"
        resource_group_name = "myresourcegroup2"
        zone_type           = "private"
        record              = "mytarget3.contoso.com"
        ttl                 = 7200
      },
    ]
  }

  module {
    source = "../../azure/terraform-azurerm-dns"
  }

  assert {
    condition = jsonencode(output.public_cname_records) == jsonencode({
      "myresourcegroup1-myzone1.com-host1" = {
          fqdn                = "host1.myzone1.com"
          id                  = "id1"
          name                = "host1"
          record              = "mytarget1.contoso.com"
          resource_group_name = "myresourcegroup1"
          tags                = {}
          timeouts            = null
          ttl                 = 300
          target_resource_id  = null
          zone_name           = "myzone1.com"
      }
      "myresourcegroup1-myzone1.com-host2" = {
          fqdn                = "host2.myzone1.com"
          id                  = "id2"
          name                = "host2"
          record              = "mytarget2.contoso.com"
          resource_group_name = "myresourcegroup1"
          timeouts            = null
          tags                = {
              "environment" = "test"
          }
          target_resource_id  = null
          ttl                 = 3600
          zone_name           = "myzone1.com"
      }
      "myresourcegroup1-myzone1.com-host3" = {
          fqdn                = "host3.myzone1.com"
          id                  = "id3"
          name                = "host3"
          record              = null
          resource_group_name = "myresourcegroup1"
          timeouts            = null
          tags                = {
              "environment" = "test"
              "usage"       = "host3"
          }
          target_resource_id  = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/myresourcegroup1/providers/Microsoft.Network/publicIPAddresses/mypublicip1"
          ttl                 = 300
          zone_name           = "myzone1.com"
      }
    })
    error_message = "bad values"
  }

  assert {
    condition = jsonencode(output.private_cname_records) == jsonencode({
      "myresourcegroup2-myprivatezone2.com-host5" = {
          fqdn                = "host5.myprivatezone2.com"
          id                  = "id5"
          name                = "host5"
          record              = "mytarget3.contoso.com"
          resource_group_name = "myresourcegroup2"
          tags                = {}
          timeouts            = null
          ttl                 = 7200
          zone_name           = "myprivatezone2.com"
      }
    })
    error_message = "bad values"   
  }
}

run "test_mx_records" {
  variables {
    mx_records = [
      {
        name                = "host1"
        zone_name           = "myzone1.com"
        resource_group_name = "myresourcegroup1"
        records = [
          {
            preference = 10
            exchange   = "mail1.contoso.com"
          },
          {
            preference = 20
            exchange   = "mail2.contoso.com"
          },
        ]
      },
      {
        name                = "host2"
        zone_name           = "myzone1.com"
        resource_group_name = "myresourcegroup1"
        records = [
          {
            preference = 10
            exchange   = "mail1.contoso.com"
          },
          {
            preference = 20
            exchange   = "mail2.contoso.com"
          },
        ]
        tags = {
          environment = "test"
          usage       = "host3"
        }
        ttl = 3600
      },
      {
        name                = "host5"
        zone_name           = "myprivatezone2.com"
        resource_group_name = "myresourcegroup2"
        zone_type           = "private"
        records = [
          {
            preference = 10
            exchange   = "mail3.contoso.com"
          },
          {
            preference = 20
            exchange   = "mail4.contoso.com"
          }
        ]
        ttl = 7200
      },
    ]
  }

  module {
    source = "../../azure/terraform-azurerm-dns"
  }

  assert {
    condition = jsonencode(output.public_mx_records) == jsonencode({
      "myresourcegroup1-myzone1.com-host1" = {
        fqdn = "host1.myzone1.com"
        id   = "id1"
        name = "host1"
        record = [
          {
            exchange   = "mail1.contoso.com"
            preference = "10"
          },
          {
            exchange   = "mail2.contoso.com"
            preference = "20"
          },
        ]
        resource_group_name = "myresourcegroup1"
        tags                = {}
        timeouts            = null
        ttl                 = 300
        zone_name           = "myzone1.com"
      }
      "myresourcegroup1-myzone1.com-host2" = {
        fqdn = "host2.myzone1.com"
        id   = "id2"
        name = "host2"
        record = [
          {
            exchange   = "mail1.contoso.com"
            preference = "10"
          },
          {
            exchange   = "mail2.contoso.com"
            preference = "20"
          },
        ]
        resource_group_name = "myresourcegroup1"
        tags = {
          "environment" = "test"
          "usage"       = "host3"
        }
        timeouts  = null
        ttl       = 3600
        zone_name = "myzone1.com"
      }
    })
    error_message = "bad values"
  }

  assert {
    condition = jsonencode(output.private_mx_records) == jsonencode({
      "myresourcegroup2-myprivatezone2.com-host5" = {
        fqdn = "host5.myprivatezone2.com"
        id   = "id5"
        name = "host5"
        record = [
          {
            exchange   = "mail3.contoso.com"
            preference = 10
          },
          {
            exchange   = "mail4.contoso.com"
            preference = 20
          },
        ]
        resource_group_name = "myresourcegroup2"
        tags                = {}
        timeouts            = null
        ttl                 = 7200
        zone_name           = "myprivatezone2.com"
      }
    })
    error_message = "bad values"
  }
}

run "test_ns_records" {
  variables {
    ns_records = [
      {
        name                = "host1"
        zone_name           = "myzone1.com"
        resource_group_name = "myresourcegroup1"
        records = [
          "ns1.contoso.com",
          "ns2.contoso.com"
        ]
      },
      {
        name                = "host2"
        zone_name           = "myzone1.com"
        resource_group_name = "myresourcegroup1"
        records = [
          "ns1.contoso.com",
          "ns2.contoso.com"
        ]
        tags = {
          environment = "test"
          usage       = "host3"
        }
        ttl = 3600
      },
    ]
  }

  module {
    source = "../../azure/terraform-azurerm-dns"
  }

  assert {
    condition = jsonencode(output.ns_records) == jsonencode({
      "myresourcegroup1-myzone1.com-host1" = {
          fqdn                = "host1.myzone1.com"
          id                  = "id1"
          name                = "host1"
          records             = [
              "ns1.contoso.com",
              "ns2.contoso.com",
          ]
          resource_group_name = "myresourcegroup1"
          tags                = {}
          timeouts            = null
          ttl                 = 300
          zone_name           = "myzone1.com"
      }
      "myresourcegroup1-myzone1.com-host2" = {
          fqdn                = "host2.myzone1.com"
          id                  = "id2"
          name                = "host2"
          records             = [
              "ns1.contoso.com",
              "ns2.contoso.com",
          ]
          resource_group_name = "myresourcegroup1"
          tags                = {
              "environment" = "test"
              "usage"       = "host3"
          }
          timeouts            = null
          ttl                 = 3600
          zone_name           = "myzone1.com"
      }
    })
    error_message = "bad values"
  }
}

run "test_ptr_records" {
  variables {
    ptr_records = [
      {
        name                = "host1"
        zone_name           = "myzone1.com"
        resource_group_name = "myresourcegroup1"
        records = [
          "record1.contoso.com",
          "record2.contoso.com"
        ]
      },
      {
        name                = "host2"
        zone_name           = "myzone1.com"
        resource_group_name = "myresourcegroup1"
        records = [
          "record1.contoso.com",
          "record2.contoso.com"
        ]
        tags = {
          environment = "test"
          usage       = "host3"
        }
        ttl = 3600
      },
      {
        name                = "host5"
        zone_name           = "myprivatezone2.com"
        resource_group_name = "myresourcegroup2"
        zone_type           = "private"
        records = [
          "record3.contoso.com",
          "record4.contoso.com"
        ]
        ttl = 7200
      },
    ]
  }

  module {
    source = "../../azure/terraform-azurerm-dns"
  }

  assert {
    condition = jsonencode(output.public_ptr_records) == jsonencode({
      "myresourcegroup1-myzone1.com-host1" = {
          fqdn                = "host1.myzone1.com"
          id                  = "id1"
          name                = "host1"
          records             = [
              "record1.contoso.com",
              "record2.contoso.com",
          ]
          resource_group_name = "myresourcegroup1"
          tags                = {}
          timeouts            = null
          ttl                 = 300
          zone_name           = "myzone1.com"
      }
      "myresourcegroup1-myzone1.com-host2" = {
          fqdn                = "host2.myzone1.com"
          id                  = "id2"
          name                = "host2"
          records             = [
              "record1.contoso.com",
              "record2.contoso.com",
          ]
          resource_group_name = "myresourcegroup1"
          tags                = {
              "environment" = "test"
              "usage"       = "host3"
          }
          timeouts            = null
          ttl                 = 3600
          zone_name           = "myzone1.com"
      }
    })
    error_message = "bad values"
  }

  assert {
    condition = jsonencode(output.private_ptr_records) == jsonencode({
      "myresourcegroup2-myprivatezone2.com-host5" = {
          fqdn                = "host5.myprivatezone2.com"
          id                  = "id5"
          name                = "host5"
          records             = [
              "record3.contoso.com",
              "record4.contoso.com",
          ]
          resource_group_name = "myresourcegroup2"
          tags                = {}
          timeouts            = null
          ttl                 = 7200
          zone_name           = "myprivatezone2.com"
      }
    })
    error_message = "bad values"
  }
}

run "test_srv_records" {
  variables {
    srv_records = [
      {
        name                = "host1"
        zone_name           = "myzone1.com"
        resource_group_name = "myresourcegroup1"
        records = [
          {
            priority = 10
            weight   = 5
            port     = 80
            target   = "service1.contoso.com"
          },
          {
            priority = 20
            weight   = 10
            port     = 8080
            target   = "service2.contoso.com"
          },
        ]
      },
      {
        name                = "host2"
        zone_name           = "myzone1.com"
        resource_group_name = "myresourcegroup1"
        records = [
          {
            priority = 10
            weight   = 5
            port     = 80
            target   = "service1.contoso.com"
          },
          {
            priority = 20
            weight   = 10
            port     = 8080
            target   = "service2.contoso.com"
          },
        ]
        tags = {
          environment = "test"
          usage       = "host3"
        }
        ttl = 3600
      },
      {
        name                = "host5"
        zone_name           = "myprivatezone2.com"
        resource_group_name = "myresourcegroup2"
        zone_type           = "private"
        records = [
          {
            priority = 10
            weight   = 5
            port     = 80
            target   = "service1.contoso.com"
          },
          {
            priority = 20
            weight   = 10
            port     = 8080
            target   = "service2.contoso.com"
          },
        ]
        ttl = 7200
      },
    ]
  }

  module {
    source = "../../azure/terraform-azurerm-dns"
  }

  assert {
    condition = jsonencode(output.public_srv_records) == jsonencode({
      "myresourcegroup1-myzone1.com-host1" = {
        fqdn = "host1.myzone1.com"
        id   = "id1"
        name = "host1"
        record = [
          {
            port     = 8080
            priority = 20
            target   = "service2.contoso.com"
            weight   = 10
          },
          {
            port     = 80
            priority = 10
            target   = "service1.contoso.com"
            weight   = 5
          },
        ]
        resource_group_name = "myresourcegroup1"
        tags                = {}
        timeouts            = null
        ttl                 = 300
        zone_name           = "myzone1.com"
      }
      "myresourcegroup1-myzone1.com-host2" = {
        fqdn = "host2.myzone1.com"
        id   = "id2"
        name = "host2"
        record = [
          {
            port     = 8080
            priority = 20
            target   = "service2.contoso.com"
            weight   = 10
          },
          {
            port     = 80
            priority = 10
            target   = "service1.contoso.com"
            weight   = 5
          },
        ]
        resource_group_name = "myresourcegroup1"
        tags = {
          "environment" = "test"
          "usage"       = "host3"
        }
        timeouts  = null
        ttl       = 3600
        zone_name = "myzone1.com"
      }
    })
    error_message = "bad values"
  }

  assert {
    condition = jsonencode(output.private_srv_records) == jsonencode({
      "myresourcegroup2-myprivatezone2.com-host5" = {
        fqdn = "host5.myprivatezone2.com"
        id   = "id5"
        name = "host5"
        record = [
          {
            port     = 8080
            priority = 20
            target   = "service2.contoso.com"
            weight   = 10
          },
          {
            port     = 80
            priority = 10
            target   = "service1.contoso.com"
            weight   = 5
          },
        ]
        resource_group_name = "myresourcegroup2"
        tags                = {}
        timeouts            = null
        ttl                 = 7200
        zone_name           = "myprivatezone2.com"
      }
    })
    error_message = "bad values"
  }
}

run "test_txt_records" {
  variables {
    txt_records = [
      {
        name                = "host1"
        zone_name           = "myzone1.com"
        resource_group_name = "myresourcegroup1"
        records = [
          "v=spf1 include:contoso.com -all",
          "some other text record"
        ]
      },
      {
        name                = "host2"
        zone_name           = "myzone1.com"
        resource_group_name = "myresourcegroup1"
        records = [
          "v=spf1 include:contoso.com -all",
          "some other text record"
        ]
        tags = {
          environment = "test"
          usage       = "host3"
        }
        ttl = 3600
      },
      {
        name                = "host5"
        zone_name           = "myprivatezone2.com"
        resource_group_name = "myresourcegroup2"
        zone_type           = "private"
        records = [
          "a record for private zone",
          "another record for private zone"
        ]
        ttl = 7200
      },
    ]
  }

  module {
    source = "../../azure/terraform-azurerm-dns"
  }

  assert {
    condition = jsonencode(output.public_txt_records) == jsonencode({
      "myresourcegroup1-myzone1.com-host1" = {
          fqdn                = "host1.myzone1.com"
          id                  = "id1"
          name                = "host1"
          record              = [
              {
                  value = "some other text record"
              },
              {
                  value = "v=spf1 include:contoso.com -all"
              },
          ]
          resource_group_name = "myresourcegroup1"
          tags                = {}
          timeouts            = null
          ttl                 = 300
          zone_name           = "myzone1.com"
      }
      "myresourcegroup1-myzone1.com-host2" = {
          fqdn                = "host2.myzone1.com"
          id                  = "id2"
          name                = "host2"
          record              = [
              {
                  value = "some other text record"
              },
              {
                  value = "v=spf1 include:contoso.com -all"
              },
          ]
          resource_group_name = "myresourcegroup1"
          tags                = {
              "environment" = "test"
              "usage"       = "host3"
          }
          timeouts            = null
          ttl                 = 3600
          zone_name           = "myzone1.com"
      }
    })
    error_message = "bad values"
  }

  assert {
    condition = jsonencode(output.private_txt_records) == jsonencode({
      "myresourcegroup2-myprivatezone2.com-host5" = {
          fqdn                = "host5.myprivatezone2.com"
          id                  = "id5"
          name                = "host5"
          record              = [
              {
                  value = "a record for private zone"
              },
              {
                  value = "another record for private zone"
              },
          ]
          resource_group_name = "myresourcegroup2"
          tags                = {}
          timeouts            = null
          ttl                 = 7200
          zone_name           = "myprivatezone2.com"
      }
    })
    error_message = "bad values"
  }
}

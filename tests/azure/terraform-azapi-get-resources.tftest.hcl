mock_provider "azurerm" {
  override_during = plan
  # alias = "azurerm_mock"
}

# mock_provider "azapi" {
#   override_during = plan
#   # alias = "azapi_mock"
# }

override_data {
  target = data.azurerm_subscription.current
  values = {
    subscription_id = "00000000-0000-0000-0000-000000000000"
  }
}

override_data {
  target = data.azapi_resource_list.resources
  values = {
    output = {
      value = [
        {
          id       = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/myrg/providers/Microsoft.KeyVault/vaults/testkv"
          name     = "testkv"
          type     = "Microsoft.KeyVault/vaults"
          location = "uksouth"
          tags = {
            "Usage"       = "usage1"
            "Environment" = "env1"
          }
        },
        {
          id       = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/myrg/providers/Microsoft.KeyVault/vaults/testkv2"
          name     = "testkv2"
          type     = "Microsoft.KeyVault/vaults"
          location = "uksouth"
          tags = {
            "Usage"       = "testusage"
            "Environment" = "testenv"
          }
        },
        {
          id       = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/myrg/providers/Microsoft.KeyVault/vaults/testkv3"
          name     = "testkv3"
          type     = "Microsoft.KeyVault/vaults"
          location = "uksouth"
          tags = {
            "Usage"       = "testusage"
            "Environment" = "testenv3"
          }
        },
        {
          id       = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/myrg2/providers/Microsoft.KeyVault/vaults/testkv4"
          name     = "testkv4"
          type     = "Microsoft.KeyVault/vaults"
          location = "useast"
          tags = {
            "Usage"       = "usage4"
            "Environment" = "env4"
          }
        }
      ]
    }
  }
}

run "test_no_filter" {
  variables {
    type = "microsoft.keyvault/vaults"
  }

  module {
    source = "../../azure/terraform-azapi-get-resources"
  }

  assert {
    condition = output.resources == [
      {
        id       = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/myrg/providers/Microsoft.KeyVault/vaults/testkv"
        name     = "testkv"
        type     = "Microsoft.KeyVault/vaults"
        location = "uksouth"
        tags = {
          "Usage"       = "usage1"
          "Environment" = "env1"
        }
      },
      {
        id       = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/myrg/providers/Microsoft.KeyVault/vaults/testkv2"
        name     = "testkv2"
        type     = "Microsoft.KeyVault/vaults"
        location = "uksouth"
        tags = {
          "Usage"       = "testusage"
          "Environment" = "testenv"
        }
      },
      {
        id       = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/myrg/providers/Microsoft.KeyVault/vaults/testkv3"
        name     = "testkv3"
        type     = "Microsoft.KeyVault/vaults"
        location = "uksouth"
        tags = {
          "Usage"       = "testusage"
          "Environment" = "testenv3"
        }
      },
      {
        id       = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/myrg2/providers/Microsoft.KeyVault/vaults/testkv4"
        name     = "testkv4"
        type     = "Microsoft.KeyVault/vaults"
        location = "useast"
        tags = {
          "Usage"       = "usage4"
          "Environment" = "env4"
        }
      }
    ]
    error_message = "bad values"
  }
}

run "test_no_filter_return_resources_with_only_id_and_name" {
  variables {
    return_attributes = ["id", "name"]
    type              = "microsoft.keyvault/vaults"
  }

  module {
    source = "../../azure/terraform-azapi-get-resources"
  }

  assert {
    condition = output.resources == [
      {
        id   = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/myrg/providers/Microsoft.KeyVault/vaults/testkv"
        name = "testkv"
      },
      {
        id   = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/myrg/providers/Microsoft.KeyVault/vaults/testkv2"
        name = "testkv2"
      },
      {
        id   = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/myrg/providers/Microsoft.KeyVault/vaults/testkv3"
        name = "testkv3"
      },
      {
        id   = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/myrg2/providers/Microsoft.KeyVault/vaults/testkv4"
        name = "testkv4"
      }
    ]
    error_message = "bad values"
  }
}

run "test_name_filter" {
  # providers = {
  #   azurerm = azurerm
  #   azapi   = azapi
  # }
  variables {
    name = "testkv"
    type = "microsoft.keyvault/vaults"
  }

  module {
    source = "../../azure/terraform-azapi-get-resources"
  }

  assert {
    condition = output.resources == [
      {
        id       = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/myrg/providers/Microsoft.KeyVault/vaults/testkv"
        name     = "testkv"
        type     = "Microsoft.KeyVault/vaults"
        location = "uksouth"
        tags = {
          "Usage"       = "usage1"
          "Environment" = "env1"
        }
      }
    ]
    error_message = "bad values"
  }
}

run "test_single_tag_filter" {
  variables {
    tags = {
      "Usage" = "testusage"
    }
    type = "microsoft.keyvault/vaults"
  }

  module {
    source = "../../azure/terraform-azapi-get-resources"
  }

  assert {
    condition = output.resources == [
      {
        id       = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/myrg/providers/Microsoft.KeyVault/vaults/testkv2"
        name     = "testkv2"
        type     = "Microsoft.KeyVault/vaults"
        location = "uksouth"
        tags = {
          "Usage"       = "testusage"
          "Environment" = "testenv"
        }
      },
      {
        id       = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/myrg/providers/Microsoft.KeyVault/vaults/testkv3"
        name     = "testkv3"
        type     = "Microsoft.KeyVault/vaults"
        location = "uksouth"
        tags = {
          "Usage"       = "testusage"
          "Environment" = "testenv3"
        }
      }
    ]
    error_message = "bad values"
  }
}

run "test_multiple_tags_filter" {
  variables {
    tags = {
      "Usage"       = "testusage"
      "Environment" = "testenv"
    }
    type = "microsoft.keyvault/vaults"
  }

  module {
    source = "../../azure/terraform-azapi-get-resources"
  }

  assert {
    condition = output.resources == [
      {
        id       = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/myrg/providers/Microsoft.KeyVault/vaults/testkv2"
        name     = "testkv2"
        type     = "Microsoft.KeyVault/vaults"
        location = "uksouth"
        tags = {
          "Usage"       = "testusage"
          "Environment" = "testenv"
        }
      }
    ]
    error_message = "bad values"
  }
}

run "test_location_filter" {
  variables {
    location = "useast"
    type     = "microsoft.keyvault/vaults"
  }

  module {
    source = "../../azure/terraform-azapi-get-resources"
  }

  assert {
    condition = output.resources == [
      {
        id       = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/myrg2/providers/Microsoft.KeyVault/vaults/testkv4"
        name     = "testkv4"
        type     = "Microsoft.KeyVault/vaults"
        location = "useast"
        tags = {
          "Usage"       = "usage4"
          "Environment" = "env4"
        }
      }
    ]
    error_message = "bad values"
  }
}




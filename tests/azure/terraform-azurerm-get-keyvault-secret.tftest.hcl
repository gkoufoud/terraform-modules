mock_provider "azurerm" {
  override_during = plan
}

override_data {
  target = data.azurerm_client_config.current
  values = {
    subscription_id = "00000000-0000-0000-0000-000000000000"
  }
}

override_data {
  target = data.azurerm_key_vault_secret.secret
  values = {
    value = "test-secret-value"
  }
}

override_module {
  target = module.keyvault
  outputs = {
    resources = [
      {
        id = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/myrg/providers/Microsoft.KeyVault/vaults/testkv"
      }
    ]
  }
}

variables {
  secret_name = "test-secret"
}

run "test_key_vault_id" {

  variables {
    key_vault_id = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/myrg/providers/Microsoft.KeyVault/vaults/testkv"
  }

  module {
    source = "../../azure/terraform-azurerm-get-keyvault-secret"
  }

  assert {
    condition     = output.value == "test-secret-value"
    error_message = "bad values"
  }

  assert {
    condition     = output.keyvault_id == "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/myrg/providers/Microsoft.KeyVault/vaults/testkv"
    error_message = "bad values"
  }
}

run "test_key_vault_resource_group_and_name" {

  variables {
    key_vault_resource_group_and_name = "myrg/testkv"
  }

  module {
    source = "../../azure/terraform-azurerm-get-keyvault-secret"
  }

  assert {
    condition     = output.value == "test-secret-value"
    error_message = "bad values"
  }

  assert {
    condition     = output.keyvault_id == "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/myrg/providers/Microsoft.KeyVault/vaults/testkv"
    error_message = "bad values"
  }
}

run "test_key_vault_tags" {

  variables {
    key_vault_tags = {
      env   = "test"
      usage = "testing"
    }
  }

  module {
    source = "../../azure/terraform-azurerm-get-keyvault-secret"
  }

  assert {
    condition     = output.value == "test-secret-value"
    error_message = "bad values"
  }

  assert {
    condition     = output.keyvault_id == "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/myrg/providers/Microsoft.KeyVault/vaults/testkv"
    error_message = "bad values"
  }
}

run "test_fail_key_vault_resource_group_and_name" {

  command = plan

  variables {
    key_vault_resource_group_and_name = "wrongformat"
  }

  module {
    source = "../../azure/terraform-azurerm-get-keyvault-secret"
  }

  expect_failures = [
    var.key_vault_resource_group_and_name,
  ]
}

run "test_fail_key_vault_tags" {

  command = plan

  override_module {
    target = module.keyvault
    outputs = {
      resources = []
    }
  }

  variables {
    key_vault_tags = {
      env   = "test"
      usage = "testing"
    }
  }

  module {
    source = "../../azure/terraform-azurerm-get-keyvault-secret"
  }

  expect_failures = [
    data.azurerm_key_vault_secret.secret,
  ]
}

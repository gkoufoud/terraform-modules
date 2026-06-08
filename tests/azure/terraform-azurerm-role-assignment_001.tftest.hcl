mock_provider "azurerm" {
  override_during = plan
}

run "test_role_assignment_simple" {

  variables {
    role_definition_name = "Contributor"
    principal_id         = "10000000-0000-0000-0000-000000000000"
    scope                = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/myresourcegroup/providers/test.provider/testresourcetype/testresource"
  }

  override_resource {
    target = azurerm_role_assignment.ra
    values = {
      name               = "00000000-0000-0000-0000-000000000000"
      condition_version  = "2.0"
      id                 = "test-ra-id"
      principal_type     = "User"
      role_definition_id = "20000000-0000-0000-0000-000000000000"
    }
  }

  module {
    source = "../../azure/terraform-azurerm-role-assignment"
  }

  assert {
    condition = jsonencode(output.role_assignment) == jsonencode({
      condition                              = null
      condition_version                      = "2.0"
      delegated_managed_identity_resource_id = null
      description                            = null
      id                                     = "test-ra-id"
      name                                   = "00000000-0000-0000-0000-000000000000"
      principal_id                           = "10000000-0000-0000-0000-000000000000"
      principal_type                         = "User"
      role_definition_id                     = "20000000-0000-0000-0000-000000000000"
      role_definition_name                   = "Contributor"
      scope                                  = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/myresourcegroup/providers/test.provider/testresourcetype/testresource"
      skip_service_principal_aad_check       = false
      timeouts                               = null
    })
    error_message = "bad values"
  }

}

mock_provider "azurerm" {
  override_during = plan
}

variables {
  role_definition_name = "Contributor"
  principal_id         = "10000000-0000-0000-0000-000000000000"
  scope                = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/myresourcegroup/providers/test.provider/testresourcetype/testresource"
}

run "test_role_assignment_fail_scope" {

  command = plan

  variables {
    scope = "invalid-scope"
  }

  module {
    source = "../../azure/terraform-azurerm-role-assignment"
  }

  expect_failures = [
    var.scope,
  ]

}

run "test_role_assignment_fail_role_assignment_name" {

  command = plan

  variables {
    role_assignment_name = "invalid-role-assignment-name"
  }

  module {
    source = "../../azure/terraform-azurerm-role-assignment"
  }

  expect_failures = [
    var.role_assignment_name,
  ]

}

run "test_role_assignment_fail_principal_type" {

  command = plan

  variables {
    principal_type = "InvalidPrincipalType"
  }

  module {
    source = "../../azure/terraform-azurerm-role-assignment"
  }

  expect_failures = [
    var.principal_type,
  ]

}

run "test_role_assignment_fail_principal_id" {

  command = plan

  variables {
    principal_id = "InvalidPrincipalId"
  }

  module {
    source = "../../azure/terraform-azurerm-role-assignment"
  }

  expect_failures = [
    var.principal_id,
  ]

}

run "test_role_assignment_fail_role_definition_id" {

  command = plan

  variables {
    role_definition_id = "InvalidRoleDefinitionId"
  }

  module {
    source = "../../azure/terraform-azurerm-role-assignment"
  }

  expect_failures = [
    var.role_definition_id,
  ]

}

run "test_role_assignment_fail_role_definition_name" {

  command = plan

  variables {
    role_definition_name = "t12"
  }

  module {
    source = "../../azure/terraform-azurerm-role-assignment"
  }

  expect_failures = [
    var.role_definition_name,
  ]

}

mock_provider "azurerm" {
  override_during = plan
}

override_resource {
  target = azurerm_management_lock.lock
  values = {
    id = "test-lock-id"
  }
}

variables {
  lock_name  = "testlock"
  lock_level = "CanNotDelete"
  scope      = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/myresourcegroup/providers/test.provider/testresourcetype/testresource"
}

run "test_lock_simple" {

  module {
    source = "../../azure/terraform-azurerm-resource-lock"
  }

  assert {
    condition = jsonencode(output.lock) == jsonencode({
      id         = "test-lock-id"
      lock_level = var.lock_level
      name       = var.lock_name
      notes      = var.notes
      scope      = var.scope
      timeouts   = null
    })
    error_message = "bad values"
  }

}

run "test_lock_notes" {

  module {
    source = "../../azure/terraform-azurerm-resource-lock"
  }

  variables {
    notes      = "This is a test lock with notes."
    lock_level = "ReadOnly"
  }

  assert {
    condition = jsonencode(output.lock) == jsonencode({
      id         = "test-lock-id"
      lock_level = var.lock_level
      name       = var.lock_name
      notes      = var.notes
      scope      = var.scope
      timeouts   = null
    })
    error_message = "bad values"
  }

}

run "test_lock_fail_scope" {

  command = plan

  module {
    source = "../../azure/terraform-azurerm-resource-lock"
  }

  variables {
    scope = "invalid-scope"
  }

  expect_failures = [
    var.scope,
  ]

}

run "test_lock_fail_lock_level" {

  command = plan

  module {
    source = "../../azure/terraform-azurerm-resource-lock"
  }

  variables {
    lock_level = "invalid-lock-level"
  }

  expect_failures = [
    var.lock_level,
  ]

}

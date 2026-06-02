resource "azurerm_role_assignment" "ra" {
  name                 = var.role_assignment_name
  principal_type       = var.principal_type
  principal_id         = var.principal_id
  role_definition_name = var.role_definition_name
  role_definition_id   = var.role_definition_id
  scope                = var.scope
  lifecycle {
    precondition {
      # This checks that at least ONE of role_definition_id or role_definition_name is NOT null
      condition     = var.role_definition_id != null || var.role_definition_name != null
      error_message = "You must provide either a 'role_definition_id' or a 'role_definition_name'. Both cannot be null."
    }
  }
}
data "azurerm_client_config" "current" {}

module "managed_identity_example" {
  source              = "git::https://github.com/gkoufoud/terraform-modules.git//azure/terraform-azurerm-managed-identity"
  name                = "example-managed-identity"
  resource_group_name = "example-resource-group"
  location            = "uksouth"
  tags = {
    environment = "prod"
  }
}

module "role_assignment_example" {
  source               = "../../../azure/terraform-azurerm-role-assignment"
  scope                = "/subscriptions/${data.azurerm_client_config.current.subscription_id}"
  role_definition_name = "Reader"
  principal_id         = module.managed_identity_example.managed_identity.principal_id
}

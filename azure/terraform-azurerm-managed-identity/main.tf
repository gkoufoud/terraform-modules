resource "azurerm_user_assigned_identity" "managed-identity" {
  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location
  tags                = var.tags
}

resource "azurerm_federated_identity_credential" "federated-credential" {
  for_each = {
    for credential in var.federated_identity_credentials : credential.name => credential
  }
  name                      = each.value.name
  audience                  = each.value.audience
  issuer                    = each.value.issuer
  user_assigned_identity_id = azurerm_user_assigned_identity.managed-identity.id
  subject                   = "system:serviceaccount:${each.value.namespace}:${each.value.service_account_name}"
}

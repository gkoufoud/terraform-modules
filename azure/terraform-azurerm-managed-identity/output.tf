output "managed_identity" {
  value = azurerm_user_assigned_identity.managed-identity
}

output "federated_identity_credentials" {
  value = azurerm_federated_identity_credential.federated-credential
}

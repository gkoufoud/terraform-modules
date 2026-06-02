output "keyvault_id" {
  value = local.key_vault_id
}

output "value" {
  value = data.azurerm_key_vault_secret.secret.value
  sensitive = true
}
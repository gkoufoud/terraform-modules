locals {
  key_vault_id = (
    var.key_vault_id != "" ?
    var.key_vault_id :
    var.key_vault_resource_group_and_name != "" ?
    "/subscriptions/${data.azurerm_client_config.current.subscription_id}/resourceGroups/${split("/", var.key_vault_resource_group_and_name)[0]}/providers/Microsoft.KeyVault/vaults/${split("/", var.key_vault_resource_group_and_name)[1]}" :
    try(module.keyvault[0].resources[0].id, "")
  )
}


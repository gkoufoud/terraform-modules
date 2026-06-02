data "azurerm_client_config" "current" {}

module "keyvault" {
  source            = "git::https://github.com/gkoufoud/terraform-modules.git//azure/terraform-azapi-get-resources"
  type              = "microsoft.keyvault/vaults"
  tags              = var.key_vault_tags
  return_attributes = ["id"]
}

data "azurerm_key_vault_secret" "secret" {
  name         = var.secret_name
  key_vault_id = local.key_vault_id
}

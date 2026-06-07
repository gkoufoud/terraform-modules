data "azurerm_client_config" "current" {}

module "keyvault" {
  count             = var.key_vault_tags != {} ? 1 : 0
  source            = "git::https://github.com/gkoufoud/terraform-modules.git//azure/terraform-azapi-get-resources"
  type              = "microsoft.keyvault/vaults"
  tags              = var.key_vault_tags
  return_attributes = ["id"]
}

data "azurerm_key_vault_secret" "secret" {
  name         = var.secret_name
  key_vault_id = local.key_vault_id
  lifecycle {
    precondition {
      condition     = local.key_vault_id != ""
      error_message = "The Key Vault ID must not be empty."
    }
  }
}

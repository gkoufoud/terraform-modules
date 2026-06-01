data "azurerm_subscription" "current" {}

data "azapi_resource_list" "resources" {
  type                   = "${local.type_provider}/${local.type_resource_type}@${local.api_version}"
  parent_id              = var.parent_id != "" ? var.parent_id : "/subscriptions/${data.azurerm_subscription.current.subscription_id}"
  response_export_values = ["value"]
}

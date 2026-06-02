resource "azurerm_management_lock" "lock" {
  name       = var.lock_name
  scope      = var.scope
  lock_level = var.lock_level
  notes      = var.notes
}

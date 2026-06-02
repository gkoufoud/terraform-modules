# https://learn.microsoft.com/en-us/azure/azure-resource-manager/management/resource-name-rules
output "value" {
  value = var.resource_name
  precondition {
    condition     = length(var.resource_name) >= local.min_length && length(var.resource_name) <= local.max_length && can(regex(local.regex_pattern, var.resource_name))
    error_message = "The ${var.resource_type} name ${var.resource_name} is not valid. It must be between ${local.min_length} and ${local.max_length} characters long. ${local.error_message_details}"
  }
}
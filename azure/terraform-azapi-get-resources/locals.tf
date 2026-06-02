locals {
  api_versions = jsondecode(file("${path.module}/${var.api_versions_file}"))

  # The regex matches the start (^), grabs everything that isn't a slash into 'provider', 
  # matches the first slash, and grabs everything else into 'resource_type' ($)
  parsed = regex("^(?P<provider>[^/]+)/(?P<resource_type>.+)$", lower(var.type))

  type_provider      = local.parsed.provider
  type_resource_type = local.parsed.resource_type

  api_version = lookup(lookup(local.api_versions, lower(local.type_provider), {}), lower(local.type_resource_type), "api version not found")

  resources_after_name = [
    for resource in data.azapi_resource_list.resources.output.value :
    resource if var.name == "" || lookup(resource, "name", "") == var.name
  ]

  resources_after_tags = [
    for resource in local.resources_after_name :
    resource if length(var.tags) == 0 || alltrue([
      for k, v in var.tags :
      lookup(lookup(resource, "tags", {}), k, "") == v
    ])
  ]

  resources_after_location = [
    for resource in local.resources_after_tags :
    resource if var.location == "" || lookup(resource, "location", "") == var.location
  ]

  return_attributes = length(var.return_attributes) > 0 ? jsonencode(var.return_attributes) : jsonencode(distinct(flatten([
    for resource in data.azapi_resource_list.resources.output.value :
    keys(resource)
  ])))

  resources_with_attribute_filter = [
    for resource in local.resources_after_location :
    {
      # for attr in var.return_attributes :
      for attr in jsondecode(local.return_attributes) :
      attr => lookup(resource, attr, null)
    }
  ]
}
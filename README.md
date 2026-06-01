# terraform-modules

A collection of reusable Terraform modules for Microsoft Azure.

---

## Table of Contents

- [Modules](#modules)
  - [Azure](#azure)
    - [terraform-azapi-get-resources](#terraform-azapi-get-resources)
      - [Overview](#overview)
      - [How It Works](#how-it-works)
      - [Requirements](#requirements)
      - [Inputs](#inputs)
      - [Outputs](#outputs)
      - [Usage](#usage)
      - [Examples](#examples)

---

## Modules

### Azure

#### terraform-azapi-get-resources

**Path:** `azure/terraform-azapi-get-resources`

##### Overview

This module queries Azure for a list of resources of a given type and returns them after applying a chain of optional filters. It uses the [`azapi`](https://registry.terraform.io/providers/azure/azapi/latest) provider's `azapi_resource_list` data source, which means it works with **any** Azure resource type and is not limited to the resource types natively supported by the `azurerm` provider.

API versions are resolved automatically from a bundled `api_versions.json` lookup table that ships with the module, so callers do not need to specify or manage API versions manually.

##### How It Works

Internally, the module runs resources through a sequential filter pipeline before returning the result:

```
azapi_resource_list
        │
        ▼
 filter by name          (var.name)
        │
        ▼
 filter by tags          (var.tags — all key/value pairs must match)
        │
        ▼
 filter by location      (var.location)
        │
        ▼
 project attributes      (var.return_attributes — all keys if empty)
        │
        ▼
   output: resources
```

Each filter step is a no-op when its corresponding variable is left at its default value, so any combination of filters can be used independently.

The `type` input follows the Azure Resource Manager `Provider/ResourceType` convention (e.g. `microsoft.keyvault/vaults`). The module parses this string, looks up the appropriate API version from the bundled table, and constructs the full `azapi` type string (`Provider/ResourceType@APIVersion`) at plan time.

#### Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.0 |
| [azure/azapi](https://registry.terraform.io/providers/azure/azapi/latest) | ~> 2.10 |
| [hashicorp/azurerm](https://registry.terraform.io/providers/hashicorp/azurerm/latest) | >= 3.0 |

> **Note:** `azurerm` is required only to resolve the current subscription ID when `parent_id` is not provided. The `azurerm` provider must be configured in the calling root module.

##### Inputs

| Name | Type | Default | Required | Description |
|------|------|---------|----------|-------------|
| `type` | `string` | — | **yes** | Azure resource type in `Provider/ResourceType` format (e.g. `microsoft.keyvault/vaults`, `microsoft.storage/storageaccounts`). Case-insensitive. |
| `parent_id` | `string` | `""` | no | Azure resource ID of the scope to query. Accepts a subscription ID (`/subscriptions/{id}`) or a resource group ID (`/subscriptions/{id}/resourceGroups/{name}`). Defaults to the current subscription when left empty. |
| `name` | `string` | `""` | no | Exact resource name to filter by. When empty, no name filter is applied. |
| `tags` | `map(string)` | `{}` | no | Map of tag key/value pairs to filter by. A resource must have **all** specified tags with the exact matching values to be included. When empty, no tag filter is applied. |
| `location` | `string` | `""` | no | Azure region to filter by (e.g. `westeurope`, `eastus`). When empty, no location filter is applied. |
| `return_attributes` | `list(string)` | `[]` | no | List of top-level resource attributes to include in each result object (e.g. `["id", "name", "location"]`). When empty, all attributes present on the resources are returned. |

#### Outputs

| Name | Type | Description |
|------|------|-------------|
| `resources` | `list(map(any))` | List of resource objects that matched all active filters. Each object contains only the keys defined in `return_attributes`, or all available keys when `return_attributes` is empty. |
| `return_attributes` | `string` | JSON-encoded list of attribute keys that were used for the attribute projection step. Useful for introspection when `return_attributes` was not explicitly set. |

##### Usage

```hcl
module "get_resources" {
  source = "path/to/azure/terraform-azapi-get-resources"

  # Required
  type = "microsoft.keyvault/vaults"

  # Optional filters
  parent_id         = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/my-rg"
  name              = "my-keyvault"
  location          = "westeurope"
  tags = {
    Environment = "prod"
    Team        = "platform"
  }

  # Optional attribute projection
  return_attributes = ["id", "name", "location", "tags"]
}

output "vault_ids" {
  value = [for r in module.get_resources.resources : r.id]
}
```

##### Examples

A runnable example is provided under `examples/terraform-azapi-get-resources/`.

**Filter by name, return all attributes**

```hcl
module "resource_by_name_return_all_attributes" {
  source = "../../azure/terraform-azapi-get-resources"
  type   = "microsoft.keyvault/vaults"
  name   = "my-keyvault"
}

output "vault" {
  value = module.resource_by_name_return_all_attributes.resources
}
```

**Filter by name, return only the resource ID**

```hcl
module "resource_by_name_return_id" {
  source            = "../../azure/terraform-azapi-get-resources"
  type              = "microsoft.keyvault/vaults"
  name              = "my-keyvault"
  return_attributes = ["id"]
}

output "vault_id" {
  value = module.resource_by_name_return_id.resources[0].id
}
```

**Filter by tags, return all attributes**

```hcl
module "resource_by_tags_return_all_attributes" {
  source = "../../azure/terraform-azapi-get-resources"
  type   = "microsoft.keyvault/vaults"
  tags = {
    Usage       = "infra"
    Environment = "prod"
  }
}

output "vault_id" {
  value = module.resource_by_tags_return_all_attributes.resources[0].id
}
```

**Filter by location across an entire subscription**

```hcl
module "vnets_in_region" {
  source    = "../../azure/terraform-azapi-get-resources"
  type      = "microsoft.network/virtualnetworks"
  location  = "northeurope"
  return_attributes = ["id", "name", "location"]
}
```

---

## License

See [LICENSE](LICENSE).

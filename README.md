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
    - [terraform-azurerm-get-keyvault-secret](#terraform-azurerm-get-keyvault-secret)
      - [Overview](#overview-1)
      - [How It Works](#how-it-works-1)
      - [Requirements](#requirements-1)
      - [Inputs](#inputs-1)
      - [Outputs](#outputs-1)
      - [Usage](#usage-1)
      - [Examples](#examples-1)
    - [terraform-azurerm-managed-identity](#terraform-azurerm-managed-identity)
      - [Overview](#overview-2)
      - [Requirements](#requirements-2)
      - [Inputs](#inputs-2)
      - [Outputs](#outputs-2)
      - [Usage](#usage-2)
      - [Examples](#examples-2)

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

#### terraform-azurerm-get-keyvault-secret

**Path:** `azure/terraform-azurerm-get-keyvault-secret`

##### Overview

This module retrieves a secret value from an Azure Key Vault. It accepts multiple ways to identify the target Key Vault — by resource ID, by resource group and name, or by tags — resolving them in priority order so callers can use whichever identifier is most convenient.

##### How It Works

The module resolves the Key Vault ID using the following priority order:

```
 key_vault_id provided?
        │ yes → use directly
        │ no
        ▼
 key_vault_resource_group_and_name provided?
        │ yes → construct ID from subscription + resource group + name
        │ no
        ▼
 look up Key Vault by tags
 (delegates to terraform-azapi-get-resources)
        │
        ▼
 azurerm_key_vault_secret (data source)
        │
        ▼
   output: value
```

Once the Key Vault ID is resolved, the module fetches the named secret using the `azurerm_key_vault_secret` data source.

##### Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.0 |
| [hashicorp/azurerm](https://registry.terraform.io/providers/hashicorp/azurerm/latest) | ~> 4.74 |

##### Inputs

| Name | Type | Default | Required | Description |
|------|------|---------|----------|-------------|
| `secret_name` | `string` | — | **yes** | The name of the Key Vault secret to retrieve. |
| `key_vault_id` | `string` | `""` | no | The full Azure resource ID of the Key Vault. Takes priority over all other Key Vault identifiers. |
| `key_vault_resource_group_and_name` | `string` | `""` | no | Resource group and Key Vault name in `resource-group/name` format (e.g. `my-rg/my-keyvault`). Used when `key_vault_id` is not provided. |
| `key_vault_tags` | `map(string)` | `{}` | no | Map of tag key/value pairs to locate the Key Vault when neither `key_vault_id` nor `key_vault_resource_group_and_name` is provided. |

##### Outputs

| Name | Type | Description |
|------|------|-------------|
| `keyvault_id` | `string` | The resolved resource ID of the Key Vault. |
| `value` | `string` (sensitive) | The value of the retrieved secret. |

##### Usage

```hcl
module "get_keyvault_secret" {
  source = "path/to/azure/terraform-azurerm-get-keyvault-secret"

  secret_name  = "my-secret"

  # Option 1: provide the Key Vault resource ID directly
  key_vault_id = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/my-rg/providers/Microsoft.KeyVault/vaults/my-keyvault"

  # Option 2: provide resource group and name
  # key_vault_resource_group_and_name = "my-rg/my-keyvault"

  # Option 3: locate by tags
  # key_vault_tags = {
  #   Environment = "prod"
  #   Team        = "platform"
  # }
}

output "secret_value" {
  value     = module.get_keyvault_secret.value
  sensitive = true
}
```

##### Examples

A runnable example is provided under `examples/azure/terraform-azurerm-get-keyvault-secret/`.

**Retrieve a secret by Key Vault resource ID**

```hcl
module "get_key_vault_secret" {
  source       = "../../../azure/terraform-azurerm-get-keyvault-secret"
  secret_name  = "my-secret"
  key_vault_id = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/my-rg/providers/Microsoft.KeyVault/vaults/my-keyvault"
}

output "key_vault_secret_value" {
  value     = module.get_key_vault_secret.value
  sensitive = true
}
```

**Retrieve a secret by resource group and Key Vault name**

```hcl
module "get_key_vault_secret" {
  source                            = "../../../azure/terraform-azurerm-get-keyvault-secret"
  secret_name                       = "my-secret"
  key_vault_resource_group_and_name = "my-rg/my-keyvault"
}

output "key_vault_secret_value" {
  value     = module.get_key_vault_secret.value
  sensitive = true
}
```

**Retrieve a secret from a Key Vault located by tags**

```hcl
module "get_key_vault_secret" {
  source      = "../../../azure/terraform-azurerm-get-keyvault-secret"
  secret_name = "my-secret"
  key_vault_tags = {
    Environment = "prod"
    Team        = "platform"
  }
}

output "key_vault_secret_value" {
  value     = module.get_key_vault_secret.value
  sensitive = true
}
```

#### terraform-azurerm-managed-identity

**Path:** `azure/terraform-azurerm-managed-identity`

##### Overview

This module creates an Azure [User-Assigned Managed Identity](https://learn.microsoft.com/en-us/entra/identity/managed-identities-azure-resources/overview) and optionally attaches one or more [Federated Identity Credentials](https://learn.microsoft.com/en-us/entra/workload-id/workload-identity-federation) to it. Federated credentials allow workloads running outside Azure (e.g. Kubernetes pods via AKS OIDC) to authenticate as the managed identity without managing secrets.

##### Requirements

| Name | Version |
|------|--------|
| terraform | >= 1.0 |
| [hashicorp/azurerm](https://registry.terraform.io/providers/hashicorp/azurerm/latest) | ~> 4.74 |

##### Inputs

| Name | Type | Default | Required | Description |
|------|------|---------|----------|-------------|
| `name` | `string` | — | **yes** | The name of the managed identity. Must be at least 4 characters long. |
| `resource_group_name` | `string` | — | **yes** | The name of the resource group in which to create the managed identity. Must be at least 4 characters long. |
| `location` | `string` | `"uksouth"` | no | The Azure region in which to create the managed identity. |
| `tags` | `map(string)` | `{}` | no | A map of tags to assign to the managed identity. |
| `federated_identity_credentials` | `list(object)` | `[]` | no | A list of federated identity credentials to attach to the managed identity. Each object has the following fields: `name` (string), `issuer` (string), `namespace` (string), `service_account_name` (string), and optional `audience` (list of strings, defaults to `["api://AzureADTokenExchange"]`). |

##### Outputs

| Name | Type | Description |
|------|------|-------------|
| `managed_identity` | `object` | The full `azurerm_user_assigned_identity` resource object. Useful attributes include `.id`, `.principal_id`, and `.client_id`. |
| `federated_identity_credentials` | `map(object)` | A map of the created `azurerm_federated_identity_credential` resource objects, keyed by credential name. Empty when no federated credentials are configured. |

##### Usage

```hcl
module "managed_identity" {
  source = "path/to/azure/terraform-azurerm-managed-identity"

  name                = "my-managed-identity"
  resource_group_name = "my-resource-group"
  location            = "uksouth"
  tags = {
    environment = "prod"
  }

  # Optional: attach federated identity credentials
  federated_identity_credentials = [
    {
      name                 = "my-federated-credential"
      issuer               = "https://oidc.example.com/"
      namespace            = "default"
      service_account_name = "my-service-account"
    }
  ]
}

output "managed_identity_id" {
  value = module.managed_identity.managed_identity.id
}

output "managed_identity_client_id" {
  value = module.managed_identity.managed_identity.client_id
}
```

##### Examples

A runnable example is provided under `examples/azure/terraform-azurerm-managed-identity/`.

**Create a managed identity without federated credentials**

```hcl
module "managed_identity_example" {
  source              = "../../../azure/terraform-azurerm-managed-identity"
  name                = "example-managed-identity"
  resource_group_name = "example-resource-group"
  location            = "uksouth"
  tags = {
    environment = "prod"
  }
}

output "managed_identity_example_id" {
  value = module.managed_identity_example.managed_identity.id
}
```

**Create a managed identity with an AKS federated identity credential**

```hcl
data "azurerm_kubernetes_cluster" "example" {
  name                = "my-aks-cluster"
  resource_group_name = "example-resource-group"
}

module "managed_identity_fc_example" {
  source              = "../../../azure/terraform-azurerm-managed-identity"
  name                = "example-managed-identity-fc"
  resource_group_name = "example-resource-group"
  location            = "uksouth"
  tags = {
    environment = "prod"
  }
  federated_identity_credentials = [
    {
      name                 = "example-federated-credential"
      issuer               = data.azurerm_kubernetes_cluster.example.oidc_issuer_url
      namespace            = "default"
      service_account_name = "example-service-account"
    }
  ]
}

output "managed_identity_fc_example_id" {
  value = module.managed_identity_fc_example.managed_identity.id
}
```

---

## License

See [LICENSE](LICENSE).

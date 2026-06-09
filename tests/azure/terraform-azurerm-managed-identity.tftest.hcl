mock_provider "azurerm" {
  override_during = plan
}

override_resource {
  target = azurerm_user_assigned_identity.managed-identity
  values = {
    client_id    = "10000000-0000-0000-0000-000000000000"
    id           = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/myresourcegroup/providers/Microsoft.ManagedIdentity/userAssignedIdentities/myidentity"
    principal_id = "20000000-0000-0000-0000-000000000000"
    tenant_id    = "30000000-0000-0000-0000-000000000000"
  }
}

variables {
  name                = "myidentity"
  resource_group_name = "myresourcegroup"
}

run "test_managed_identity_simple" {

  module {
    source = "../../azure/terraform-azurerm-managed-identity"
  }

  assert {
    condition = jsonencode(output.managed_identity) == jsonencode({
      client_id           = "10000000-0000-0000-0000-000000000000"
      id                  = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/myresourcegroup/providers/Microsoft.ManagedIdentity/userAssignedIdentities/myidentity"
      isolation_scope     = null
      location            = "uksouth"
      name                = "myidentity"
      principal_id        = "20000000-0000-0000-0000-000000000000"
      resource_group_name = "myresourcegroup"
      tags                = {}
      timeouts            = null
      tenant_id           = "30000000-0000-0000-0000-000000000000"
    })
    error_message = "bad values"
  }

  assert {
    condition     = output.federated_identity_credentials == {}
    error_message = "federated_identity_credentials should be empty"
  }
}

run "test_managed_identity_location_and_tags" {

  variables {
    location = "ussouth"
    tags = {
      environment = "test"
      usage       = "testing"
    }
  }

  module {
    source = "../../azure/terraform-azurerm-managed-identity"
  }

  assert {
    condition = jsonencode(output.managed_identity) == jsonencode({
      client_id           = "10000000-0000-0000-0000-000000000000"
      id                  = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/myresourcegroup/providers/Microsoft.ManagedIdentity/userAssignedIdentities/myidentity"
      isolation_scope     = null
      location            = "ussouth"
      name                = "myidentity"
      principal_id        = "20000000-0000-0000-0000-000000000000"
      resource_group_name = "myresourcegroup"
      tags = {
        environment = "test"
        usage       = "testing"
      }
      timeouts  = null
      tenant_id = "30000000-0000-0000-0000-000000000000"
    })
    error_message = "bad values"
  }

  assert {
    condition     = output.federated_identity_credentials == {}
    error_message = "federated_identity_credentials should be empty"
  }
}

run "test_managed_identity_with_single_federated_identity_credential" {

  variables {
    federated_identity_credentials = [
      {
        name                 = "credential-1"
        issuer               = "https://sts.windows.net/00000000-0000-0000-0000-000000000000/"
        namespace            = "namespace-1"
        service_account_name = "service-account-1"
      }
    ]
  }

  override_resource {
    target = azurerm_federated_identity_credential.federated-credential["credential-1"]
    values = {
      id                  = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/myresourcegroup/providers/Microsoft.ManagedIdentity/userAssignedIdentities/myidentity/federatedIdentityCredentials/credential-1"
      parent_id           = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/myresourcegroup/providers/Microsoft.ManagedIdentity/userAssignedIdentities/myidentity"
      resource_group_name = "myresourcegroup"
    }
  }

  module {
    source = "../../azure/terraform-azurerm-managed-identity"
  }

  assert {
    condition = jsonencode(output.managed_identity) == jsonencode({
      client_id           = "10000000-0000-0000-0000-000000000000"
      id                  = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/myresourcegroup/providers/Microsoft.ManagedIdentity/userAssignedIdentities/myidentity"
      isolation_scope     = null
      location            = "uksouth"
      name                = "myidentity"
      principal_id        = "20000000-0000-0000-0000-000000000000"
      resource_group_name = "myresourcegroup"
      tags                = {}
      timeouts            = null
      tenant_id           = "30000000-0000-0000-0000-000000000000"
    })
    error_message = "bad values"
  }

  assert {
    condition = jsonencode(output.federated_identity_credentials) == jsonencode({
      "credential-1" = {
        audience = [
          "api://AzureADTokenExchange",
        ]
        id                        = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/myresourcegroup/providers/Microsoft.ManagedIdentity/userAssignedIdentities/myidentity/federatedIdentityCredentials/credential-1"
        issuer                    = "https://sts.windows.net/00000000-0000-0000-0000-000000000000/"
        name                      = "credential-1"
        parent_id                 = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/myresourcegroup/providers/Microsoft.ManagedIdentity/userAssignedIdentities/myidentity"
        resource_group_name       = "myresourcegroup"
        subject                   = "system:serviceaccount:namespace-1:service-account-1"
        timeouts                  = null
        user_assigned_identity_id = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/myresourcegroup/providers/Microsoft.ManagedIdentity/userAssignedIdentities/myidentity"
      }
    })
    error_message = "bad values"
  }

}

run "test_managed_identity_with_multiple_federated_identity_credentials" {

  variables {
    federated_identity_credentials = [
      {
        name                 = "credential-1"
        issuer               = "https://sts.windows.net/00000000-0000-0000-0000-000000000000/"
        namespace            = "namespace-1"
        service_account_name = "service-account-1"
      },
      {
        name                 = "credential-2"
        issuer               = "https://sts.windows.net/00000000-0000-0000-0000-000000000000/"
        namespace            = "namespace-2"
        service_account_name = "service-account-2"
      }
    ]
  }

  override_resource {
    target = azurerm_federated_identity_credential.federated-credential["credential-1"]
    values = {
      id                  = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/myresourcegroup/providers/Microsoft.ManagedIdentity/userAssignedIdentities/myidentity/federatedIdentityCredentials/credential-1"
      parent_id           = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/myresourcegroup/providers/Microsoft.ManagedIdentity/userAssignedIdentities/myidentity"
      resource_group_name = "myresourcegroup"
    }
  }

  override_resource {
    target = azurerm_federated_identity_credential.federated-credential["credential-2"]
    values = {
      id                  = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/myresourcegroup/providers/Microsoft.ManagedIdentity/userAssignedIdentities/myidentity/federatedIdentityCredentials/credential-2"
      parent_id           = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/myresourcegroup/providers/Microsoft.ManagedIdentity/userAssignedIdentities/myidentity"
      resource_group_name = "myresourcegroup"
    }
  }
  module {
    source = "../../azure/terraform-azurerm-managed-identity"
  }

  assert {
    condition = jsonencode(output.managed_identity) == jsonencode({
      client_id           = "10000000-0000-0000-0000-000000000000"
      id                  = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/myresourcegroup/providers/Microsoft.ManagedIdentity/userAssignedIdentities/myidentity"
      isolation_scope     = null
      location            = "uksouth"
      name                = "myidentity"
      principal_id        = "20000000-0000-0000-0000-000000000000"
      resource_group_name = "myresourcegroup"
      tags                = {}
      timeouts            = null
      tenant_id           = "30000000-0000-0000-0000-000000000000"
    })
    error_message = "bad values"
  }

  assert {
    condition = jsonencode(output.federated_identity_credentials) == jsonencode({
      "credential-1" = {
        audience = [
          "api://AzureADTokenExchange",
        ]
        id                        = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/myresourcegroup/providers/Microsoft.ManagedIdentity/userAssignedIdentities/myidentity/federatedIdentityCredentials/credential-1"
        issuer                    = "https://sts.windows.net/00000000-0000-0000-0000-000000000000/"
        name                      = "credential-1"
        parent_id                 = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/myresourcegroup/providers/Microsoft.ManagedIdentity/userAssignedIdentities/myidentity"
        resource_group_name       = "myresourcegroup"
        subject                   = "system:serviceaccount:namespace-1:service-account-1"
        timeouts                  = null
        user_assigned_identity_id = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/myresourcegroup/providers/Microsoft.ManagedIdentity/userAssignedIdentities/myidentity"
      },
      "credential-2" = {
        audience = [
          "api://AzureADTokenExchange",
        ]
        id                        = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/myresourcegroup/providers/Microsoft.ManagedIdentity/userAssignedIdentities/myidentity/federatedIdentityCredentials/credential-2"
        issuer                    = "https://sts.windows.net/00000000-0000-0000-0000-000000000000/"
        name                      = "credential-2"
        parent_id                 = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/myresourcegroup/providers/Microsoft.ManagedIdentity/userAssignedIdentities/myidentity"
        resource_group_name       = "myresourcegroup"
        subject                   = "system:serviceaccount:namespace-2:service-account-2"
        timeouts                  = null
        user_assigned_identity_id = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/myresourcegroup/providers/Microsoft.ManagedIdentity/userAssignedIdentities/myidentity"
      }
    })
    error_message = "bad values"
  }

}

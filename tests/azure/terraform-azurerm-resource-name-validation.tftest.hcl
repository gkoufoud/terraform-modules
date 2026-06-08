run "test_resourcegroup_simple" {

  command = plan
  
  module {
    source = "../../azure/terraform-azurerm-resource-name-validation"
  }

  variables {
    resource_type = "resourcegroup"
    resource_name = "rg-t(e_s.t-001"
  }

}

run "test_resourcegroup_fail_min" {
  command = plan
  module {
    source = "../../azure/terraform-azurerm-resource-name-validation"
  }
  variables {
    resource_type = "resourcegroup"
    resource_name = ""
  }
  expect_failures = [
    output.value
  ]
}

run "test_resourcegroup_fail_max" {
  command = plan
  module {
    source = "../../azure/terraform-azurerm-resource-name-validation"
  }
  variables {
    resource_type = "resourcegroup"
    resource_name = join("", [for i in range(91) : "a"])
  }
  expect_failures = [
    output.value
  ]
}

run "test_resourcegroup_fail_regex_start" {
  command = plan
  module {
    source = "../../azure/terraform-azurerm-resource-name-validation"
  }
  variables {
    resource_type = "resourcegroup"
    resource_name = "-rg-test-001"
  }
  expect_failures = [
    output.value
  ]
}

run "test_resourcegroup_fail_regex_end" {
  command = plan
  module {
    source = "../../azure/terraform-azurerm-resource-name-validation"
  }
  variables {
    resource_type = "resourcegroup"
    resource_name = "rg-test-001."
  }
  expect_failures = [
    output.value
  ]
}

run "test_aks_simple" {
  command = plan
  module {
    source = "../../azure/terraform-azurerm-resource-name-validation"
  }
  variables {
    resource_type = "aks"
    resource_name = "aks-test-001"
  }
}

run "test_aks_fail_min" {
  command = plan
  module {
    source = "../../azure/terraform-azurerm-resource-name-validation"
  }
  variables {
    resource_type = "aks"
    resource_name = "ak"
  }
  expect_failures = [
    output.value
  ]
}

run "test_aks_fail_max" {
  command = plan
  module {
    source = "../../azure/terraform-azurerm-resource-name-validation"
  }
  variables {
    resource_type = "aks"
    resource_name = join("", [for i in range(31) : "a"])
  }
  expect_failures = [
    output.value
  ]
}

run "test_aks_fail_regex_start" {
  command = plan
  module {
    source = "../../azure/terraform-azurerm-resource-name-validation"
  }
  variables {
    resource_type = "aks"
    resource_name = "-aks-test-001"
  }
  expect_failures = [
    output.value
  ]
}

run "test_aks_fail_regex_end" {
  command = plan
  module {
    source = "../../azure/terraform-azurerm-resource-name-validation"
  }
  variables {
    resource_type = "aks"
    resource_name = "aks-test-001-"
  }
  expect_failures = [
    output.value
  ]
}

run "test_aksagentpool_simple" {
  command = plan
  module {
    source = "../../azure/terraform-azurerm-resource-name-validation"
  }
  variables {
    resource_type = "aksagentpool"
    resource_name = "pool-001"
  }
}

run "test_aksagentpool_fail_min" {
  command = plan
  module {
    source = "../../azure/terraform-azurerm-resource-name-validation"
  }
  variables {
    resource_type = "aksagentpool"
    resource_name = "ak"
  }
  expect_failures = [
    output.value
  ]
}

run "test_aksagentpool_fail_max" {
  command = plan
  module {
    source = "../../azure/terraform-azurerm-resource-name-validation"
  }
  variables {
    resource_type = "aksagentpool"
    resource_name = join("", [for i in range(31) : "a"])
  }
  expect_failures = [
    output.value
  ]
}

run "test_aksagentpool_fail_regex_start" {
  command = plan
  module {
    source = "../../azure/terraform-azurerm-resource-name-validation"
  }
  variables {
    resource_type = "aksagentpool"
    resource_name = "-pool-001"
  }
  expect_failures = [
    output.value
  ]
}

run "test_aksagentpool_fail_regex_end" {
  command = plan
  module {
    source = "../../azure/terraform-azurerm-resource-name-validation"
  }
  variables {
    resource_type = "aksagentpool"
    resource_name = "pool-001-"
  }
  expect_failures = [
    output.value
  ]
}

run "test_vm_windows_simple" {
  command = plan
  module {
    source = "../../azure/terraform-azurerm-resource-name-validation"
  }
  variables {
    resource_type = "vm_windows"
    resource_name = "vmwin001"
  }
}

run "test_vm_windows_fail_min" {
  command = plan
  module {
    source = "../../azure/terraform-azurerm-resource-name-validation"
  }
  variables {
    resource_type = "vm_windows"
    resource_name = ""
  }
  expect_failures = [
    output.value
  ]
}

run "test_vm_windows_fail_max" {
  command = plan
  module {
    source = "../../azure/terraform-azurerm-resource-name-validation"
  }
  variables {
    resource_type = "vm_windows"
    resource_name = join("", [for i in range(16) : "a"])
  }
  expect_failures = [
    output.value
  ]
}

run "test_vm_windows_fail_regex_start" {
  command = plan
  module {
    source = "../../azure/terraform-azurerm-resource-name-validation"
  }
  variables {
    resource_type = "vm_windows"
    resource_name = "-vmwin001"
  }
  expect_failures = [
    output.value
  ]
}

run "test_vm_windows_fail_regex_end" {
  command = plan
  module {
    source = "../../azure/terraform-azurerm-resource-name-validation"
  }
  variables {
    resource_type = "vm_windows"
    resource_name = "vmwin001-"
  }
  expect_failures = [
    output.value
  ]
}

run "test_vm_linux_simple" {
  command = plan
  module {
    source = "../../azure/terraform-azurerm-resource-name-validation"
  }
  variables {
    resource_type = "vm_linux"
    resource_name = "vm-linux-001"
  }
}

run "test_vm_linux_fail_min" {
  command = plan
  module {
    source = "../../azure/terraform-azurerm-resource-name-validation"
  }
  variables {
    resource_type = "vm_linux"
    resource_name = ""
  }
  expect_failures = [
    output.value
  ]
}

run "test_vm_linux_fail_max" {
  command = plan
  module {
    source = "../../azure/terraform-azurerm-resource-name-validation"
  }
  variables {
    resource_type = "vm_linux"
    resource_name = join("", [for i in range(65) : "a"])
  }
  expect_failures = [
    output.value
  ]
}

run "test_vm_linux_fail_regex_start" {
  command = plan
  module {
    source = "../../azure/terraform-azurerm-resource-name-validation"
  }
  variables {
    resource_type = "vm_linux"
    resource_name = "-vm-linux-001"
  }
  expect_failures = [
    output.value
  ]
}

run "test_vm_linux_fail_regex_end" {
  command = plan
  module {
    source = "../../azure/terraform-azurerm-resource-name-validation"
  }
  variables {
    resource_type = "vm_linux"
    resource_name = "vm-linux-001-"
  }
  expect_failures = [
    output.value
  ]
}

run "test_vmss_windows_simple" {
  command = plan
  module {
    source = "../../azure/terraform-azurerm-resource-name-validation"
  }
  variables {
    resource_type = "vmss_windows"
    resource_name = "vmsswin01"
  }
}

run "test_vmss_windows_fail_min" {
  command = plan
  module {
    source = "../../azure/terraform-azurerm-resource-name-validation"
  }
  variables {
    resource_type = "vmss_windows"
    resource_name = ""
  }
  expect_failures = [
    output.value
  ]
}

run "test_vmss_windows_fail_max" {
  command = plan
  module {
    source = "../../azure/terraform-azurerm-resource-name-validation"
  }
  variables {
    resource_type = "vmss_windows"
    resource_name = join("", [for i in range(16) : "a"])
  }
  expect_failures = [
    output.value
  ]
}

run "test_vmss_windows_fail_regex_start" {
  command = plan
  module {
    source = "../../azure/terraform-azurerm-resource-name-validation"
  }
  variables {
    resource_type = "vmss_windows"
    resource_name = "-vmsswin01"
  }
  expect_failures = [
    output.value
  ]
}

run "test_vmss_windows_fail_regex_end" {
  command = plan
  module {
    source = "../../azure/terraform-azurerm-resource-name-validation"
  }
  variables {
    resource_type = "vmss_windows"
    resource_name = "vmsswin01-"
  }
  expect_failures = [
    output.value
  ]
}

run "test_vmss_linux_simple" {
  command = plan
  module {
    source = "../../azure/terraform-azurerm-resource-name-validation"
  }
  variables {
    resource_type = "vmss_linux"
    resource_name = "vmss-linux-001"
  }
}

run "test_vmss_linux_fail_min" {
  command = plan
  module {
    source = "../../azure/terraform-azurerm-resource-name-validation"
  }
  variables {
    resource_type = "vmss_linux"
    resource_name = ""
  }
  expect_failures = [
    output.value
  ]
}

run "test_vmss_linux_fail_max" {
  command = plan
  module {
    source = "../../azure/terraform-azurerm-resource-name-validation"
  }
  variables {
    resource_type = "vmss_linux"
    resource_name = join("", [for i in range(65) : "a"])
  }
  expect_failures = [
    output.value
  ]
}

run "test_vmss_linux_fail_regex_start" {
  command = plan
  module {
    source = "../../azure/terraform-azurerm-resource-name-validation"
  }
  variables {
    resource_type = "vmss_linux"
    resource_name = "-vmss-linux-001"
  }
  expect_failures = [
    output.value
  ]
}

run "test_vmss_linux_fail_regex_end" {
  command = plan
  module {
    source = "../../azure/terraform-azurerm-resource-name-validation"
  }
  variables {
    resource_type = "vmss_linux"
    resource_name = "vmss-linux-001-"
  }
  expect_failures = [
    output.value
  ]
}

run "test_acr_simple" {
  command = plan
  module {
    source = "../../azure/terraform-azurerm-resource-name-validation"
  }
  variables {
    resource_type = "acr"
    resource_name = "myacr001"
  }
}

run "test_acr_fail_min" {
  command = plan
  module {
    source = "../../azure/terraform-azurerm-resource-name-validation"
  }
  variables {
    resource_type = "acr"
    resource_name = "acr1"
  }
  expect_failures = [
    output.value
  ]
}

run "test_acr_fail_max" {
  command = plan
  module {
    source = "../../azure/terraform-azurerm-resource-name-validation"
  }
  variables {
    resource_type = "acr"
    resource_name = join("", [for i in range(51) : "a"])
  }
  expect_failures = [
    output.value
  ]
}

run "test_acr_fail_regex_hyphen" {
  command = plan
  module {
    source = "../../azure/terraform-azurerm-resource-name-validation"
  }
  variables {
    resource_type = "acr"
    resource_name = "acr-test-001"
  }
  expect_failures = [
    output.value
  ]
}

run "test_acr_fail_regex_underscore" {
  command = plan
  module {
    source = "../../azure/terraform-azurerm-resource-name-validation"
  }
  variables {
    resource_type = "acr"
    resource_name = "acr_test_001"
  }
  expect_failures = [
    output.value
  ]
}

run "test_vnet_simple" {
  command = plan
  module {
    source = "../../azure/terraform-azurerm-resource-name-validation"
  }
  variables {
    resource_type = "vnet"
    resource_name = "vnet-test-001"
  }
}

run "test_vnet_fail_min" {
  command = plan
  module {
    source = "../../azure/terraform-azurerm-resource-name-validation"
  }
  variables {
    resource_type = "vnet"
    resource_name = ""
  }
  expect_failures = [
    output.value
  ]
}

run "test_vnet_fail_max" {
  command = plan
  module {
    source = "../../azure/terraform-azurerm-resource-name-validation"
  }
  variables {
    resource_type = "vnet"
    resource_name = join("", [for i in range(81) : "a"])
  }
  expect_failures = [
    output.value
  ]
}

run "test_vnet_fail_regex_start" {
  command = plan
  module {
    source = "../../azure/terraform-azurerm-resource-name-validation"
  }
  variables {
    resource_type = "vnet"
    resource_name = "-vnet-test-001"
  }
  expect_failures = [
    output.value
  ]
}

run "test_vnet_fail_regex_end" {
  command = plan
  module {
    source = "../../azure/terraform-azurerm-resource-name-validation"
  }
  variables {
    resource_type = "vnet"
    resource_name = "vnet-test-001."
  }
  expect_failures = [
    output.value
  ]
}

run "test_keyvault_simple" {
  command = plan
  module {
    source = "../../azure/terraform-azurerm-resource-name-validation"
  }
  variables {
    resource_type = "keyvault"
    resource_name = "kv-test-001"
  }
}

run "test_keyvault_fail_min" {
  command = plan
  module {
    source = "../../azure/terraform-azurerm-resource-name-validation"
  }
  variables {
    resource_type = "keyvault"
    resource_name = "kv"
  }
  expect_failures = [
    output.value
  ]
}

run "test_keyvault_fail_max" {
  command = plan
  module {
    source = "../../azure/terraform-azurerm-resource-name-validation"
  }
  variables {
    resource_type = "keyvault"
    resource_name = join("", [for i in range(25) : "a"])
  }
  expect_failures = [
    output.value
  ]
}

run "test_keyvault_fail_regex_start_digit" {
  command = plan
  module {
    source = "../../azure/terraform-azurerm-resource-name-validation"
  }
  variables {
    resource_type = "keyvault"
    resource_name = "1kv-test-001"
  }
  expect_failures = [
    output.value
  ]
}

run "test_keyvault_fail_regex_end_hyphen" {
  command = plan
  module {
    source = "../../azure/terraform-azurerm-resource-name-validation"
  }
  variables {
    resource_type = "keyvault"
    resource_name = "kv-test-001-"
  }
  expect_failures = [
    output.value
  ]
}

run "test_keyvault_fail_regex_consecutive_hyphens" {
  command = plan
  module {
    source = "../../azure/terraform-azurerm-resource-name-validation"
  }
  variables {
    resource_type = "keyvault"
    resource_name = "kv--test-001"
  }
  expect_failures = [
    output.value
  ]
}

run "test_loadbalancer_simple" {
  command = plan
  module {
    source = "../../azure/terraform-azurerm-resource-name-validation"
  }
  variables {
    resource_type = "loadbalancer"
    resource_name = "lb-test-001"
  }
}

run "test_loadbalancer_fail_min" {
  command = plan
  module {
    source = "../../azure/terraform-azurerm-resource-name-validation"
  }
  variables {
    resource_type = "loadbalancer"
    resource_name = ""
  }
  expect_failures = [
    output.value
  ]
}

run "test_loadbalancer_fail_max" {
  command = plan
  module {
    source = "../../azure/terraform-azurerm-resource-name-validation"
  }
  variables {
    resource_type = "loadbalancer"
    resource_name = join("", [for i in range(81) : "a"])
  }
  expect_failures = [
    output.value
  ]
}

run "test_loadbalancer_fail_regex_start" {
  command = plan
  module {
    source = "../../azure/terraform-azurerm-resource-name-validation"
  }
  variables {
    resource_type = "loadbalancer"
    resource_name = "-lb-test-001"
  }
  expect_failures = [
    output.value
  ]
}

run "test_loadbalancer_fail_regex_end" {
  command = plan
  module {
    source = "../../azure/terraform-azurerm-resource-name-validation"
  }
  variables {
    resource_type = "loadbalancer"
    resource_name = "lb-test-001."
  }
  expect_failures = [
    output.value
  ]
}

run "test_storageaccount_simple" {
  command = plan
  module {
    source = "../../azure/terraform-azurerm-resource-name-validation"
  }
  variables {
    resource_type = "storageaccount"
    resource_name = "mystorageacct001"
  }
}

run "test_storageaccount_fail_min" {
  command = plan
  module {
    source = "../../azure/terraform-azurerm-resource-name-validation"
  }
  variables {
    resource_type = "storageaccount"
    resource_name = "st"
  }
  expect_failures = [
    output.value
  ]
}

run "test_storageaccount_fail_max" {
  command = plan
  module {
    source = "../../azure/terraform-azurerm-resource-name-validation"
  }
  variables {
    resource_type = "storageaccount"
    resource_name = join("", [for i in range(25) : "a"])
  }
  expect_failures = [
    output.value
  ]
}

run "test_storageaccount_fail_regex_uppercase" {
  command = plan
  module {
    source = "../../azure/terraform-azurerm-resource-name-validation"
  }
  variables {
    resource_type = "storageaccount"
    resource_name = "MyStorage001"
  }
  expect_failures = [
    output.value
  ]
}

run "test_storageaccount_fail_regex_hyphen" {
  command = plan
  module {
    source = "../../azure/terraform-azurerm-resource-name-validation"
  }
  variables {
    resource_type = "storageaccount"
    resource_name = "my-storage-001"
  }
  expect_failures = [
    output.value
  ]
}

run "test_storageaccountcontainer_simple" {
  command = plan
  module {
    source = "../../azure/terraform-azurerm-resource-name-validation"
  }
  variables {
    resource_type = "storageaccountcontainer"
    resource_name = "my-container-001"
  }
}

run "test_storageaccountcontainer_fail_min" {
  command = plan
  module {
    source = "../../azure/terraform-azurerm-resource-name-validation"
  }
  variables {
    resource_type = "storageaccountcontainer"
    resource_name = "sc"
  }
  expect_failures = [
    output.value
  ]
}

run "test_storageaccountcontainer_fail_max" {
  command = plan
  module {
    source = "../../azure/terraform-azurerm-resource-name-validation"
  }
  variables {
    resource_type = "storageaccountcontainer"
    resource_name = join("", [for i in range(64) : "a"])
  }
  expect_failures = [
    output.value
  ]
}

run "test_storageaccountcontainer_fail_regex_start" {
  command = plan
  module {
    source = "../../azure/terraform-azurerm-resource-name-validation"
  }
  variables {
    resource_type = "storageaccountcontainer"
    resource_name = "-my-container-001"
  }
  expect_failures = [
    output.value
  ]
}

run "test_storageaccountcontainer_fail_regex_end" {
  command = plan
  module {
    source = "../../azure/terraform-azurerm-resource-name-validation"
  }
  variables {
    resource_type = "storageaccountcontainer"
    resource_name = "my-container-001-"
  }
  expect_failures = [
    output.value
  ]
}

run "test_storageaccountcontainer_fail_regex_consecutive_hyphens" {
  command = plan
  module {
    source = "../../azure/terraform-azurerm-resource-name-validation"
  }
  variables {
    resource_type = "storageaccountcontainer"
    resource_name = "my--container-001"
  }
  expect_failures = [
    output.value
  ]
}

run "test_fileshare_simple" {
  command = plan
  module {
    source = "../../azure/terraform-azurerm-resource-name-validation"
  }
  variables {
    resource_type = "fileshare"
    resource_name = "my-fileshare-001"
  }
}

run "test_fileshare_fail_min" {
  command = plan
  module {
    source = "../../azure/terraform-azurerm-resource-name-validation"
  }
  variables {
    resource_type = "fileshare"
    resource_name = "fs"
  }
  expect_failures = [
    output.value
  ]
}

run "test_fileshare_fail_max" {
  command = plan
  module {
    source = "../../azure/terraform-azurerm-resource-name-validation"
  }
  variables {
    resource_type = "fileshare"
    resource_name = join("", [for i in range(64) : "a"])
  }
  expect_failures = [
    output.value
  ]
}

run "test_fileshare_fail_regex_start" {
  command = plan
  module {
    source = "../../azure/terraform-azurerm-resource-name-validation"
  }
  variables {
    resource_type = "fileshare"
    resource_name = "-my-fileshare-001"
  }
  expect_failures = [
    output.value
  ]
}

run "test_fileshare_fail_regex_end" {
  command = plan
  module {
    source = "../../azure/terraform-azurerm-resource-name-validation"
  }
  variables {
    resource_type = "fileshare"
    resource_name = "my-fileshare-001-"
  }
  expect_failures = [
    output.value
  ]
}

run "test_fileshare_fail_regex_consecutive_hyphens" {
  command = plan
  module {
    source = "../../azure/terraform-azurerm-resource-name-validation"
  }
  variables {
    resource_type = "fileshare"
    resource_name = "my--fileshare-001"
  }
  expect_failures = [
    output.value
  ]
}

run "test_postgresqlserver_simple" {
  command = plan
  module {
    source = "../../azure/terraform-azurerm-resource-name-validation"
  }
  variables {
    resource_type = "postgresqlserver"
    resource_name = "my-postgres-001"
  }
}

run "test_postgresqlserver_fail_min" {
  command = plan
  module {
    source = "../../azure/terraform-azurerm-resource-name-validation"
  }
  variables {
    resource_type = "postgresqlserver"
    resource_name = "pg"
  }
  expect_failures = [
    output.value
  ]
}

run "test_postgresqlserver_fail_max" {
  command = plan
  module {
    source = "../../azure/terraform-azurerm-resource-name-validation"
  }
  variables {
    resource_type = "postgresqlserver"
    resource_name = join("", [for i in range(64) : "a"])
  }
  expect_failures = [
    output.value
  ]
}

run "test_postgresqlserver_fail_regex_start" {
  command = plan
  module {
    source = "../../azure/terraform-azurerm-resource-name-validation"
  }
  variables {
    resource_type = "postgresqlserver"
    resource_name = "-my-postgres-001"
  }
  expect_failures = [
    output.value
  ]
}

run "test_postgresqlserver_fail_regex_end" {
  command = plan
  module {
    source = "../../azure/terraform-azurerm-resource-name-validation"
  }
  variables {
    resource_type = "postgresqlserver"
    resource_name = "my-postgres-001-"
  }
  expect_failures = [
    output.value
  ]
}

run "test_postgresqlserver_fail_regex_consecutive_hyphens" {
  command = plan
  module {
    source = "../../azure/terraform-azurerm-resource-name-validation"
  }
  variables {
    resource_type = "postgresqlserver"
    resource_name = "my--postgres-001"
  }
  expect_failures = [
    output.value
  ]
}

run "test_postgresqldb_simple" {
  command = plan
  module {
    source = "../../azure/terraform-azurerm-resource-name-validation"
  }
  variables {
    resource_type = "postgresqldb"
    resource_name = "my-db-001"
  }
}

run "test_postgresqldb_fail_min" {
  command = plan
  module {
    source = "../../azure/terraform-azurerm-resource-name-validation"
  }
  variables {
    resource_type = "postgresqldb"
    resource_name = ""
  }
  expect_failures = [
    output.value
  ]
}

run "test_postgresqldb_fail_max" {
  command = plan
  module {
    source = "../../azure/terraform-azurerm-resource-name-validation"
  }
  variables {
    resource_type = "postgresqldb"
    resource_name = join("", [for i in range(64) : "a"])
  }
  expect_failures = [
    output.value
  ]
}

run "test_postgresqldb_fail_regex_start" {
  command = plan
  module {
    source = "../../azure/terraform-azurerm-resource-name-validation"
  }
  variables {
    resource_type = "postgresqldb"
    resource_name = "-my-db-001"
  }
  expect_failures = [
    output.value
  ]
}

run "test_postgresqldb_fail_regex_end" {
  command = plan
  module {
    source = "../../azure/terraform-azurerm-resource-name-validation"
  }
  variables {
    resource_type = "postgresqldb"
    resource_name = "my-db-001-"
  }
  expect_failures = [
    output.value
  ]
}

run "test_networksecuritygroup_simple" {
  command = plan
  module {
    source = "../../azure/terraform-azurerm-resource-name-validation"
  }
  variables {
    resource_type = "networksecuritygroup"
    resource_name = "nsg-test-001"
  }
}

run "test_networksecuritygroup_fail_min" {
  command = plan
  module {
    source = "../../azure/terraform-azurerm-resource-name-validation"
  }
  variables {
    resource_type = "networksecuritygroup"
    resource_name = ""
  }
  expect_failures = [
    output.value
  ]
}

run "test_networksecuritygroup_fail_max" {
  command = plan
  module {
    source = "../../azure/terraform-azurerm-resource-name-validation"
  }
  variables {
    resource_type = "networksecuritygroup"
    resource_name = join("", [for i in range(81) : "a"])
  }
  expect_failures = [
    output.value
  ]
}

run "test_networksecuritygroup_fail_regex_start" {
  command = plan
  module {
    source = "../../azure/terraform-azurerm-resource-name-validation"
  }
  variables {
    resource_type = "networksecuritygroup"
    resource_name = "-nsg-test-001"
  }
  expect_failures = [
    output.value
  ]
}

run "test_networksecuritygroup_fail_regex_end" {
  command = plan
  module {
    source = "../../azure/terraform-azurerm-resource-name-validation"
  }
  variables {
    resource_type = "networksecuritygroup"
    resource_name = "nsg-test-001."
  }
  expect_failures = [
    output.value
  ]
}

run "test_networksecuritygrouprule_simple" {
  command = plan
  module {
    source = "../../azure/terraform-azurerm-resource-name-validation"
  }
  variables {
    resource_type = "networksecuritygrouprule"
    resource_name = "nsg-rule-allow-http"
  }
}

run "test_networksecuritygrouprule_fail_min" {
  command = plan
  module {
    source = "../../azure/terraform-azurerm-resource-name-validation"
  }
  variables {
    resource_type = "networksecuritygrouprule"
    resource_name = ""
  }
  expect_failures = [
    output.value
  ]
}

run "test_networksecuritygrouprule_fail_max" {
  command = plan
  module {
    source = "../../azure/terraform-azurerm-resource-name-validation"
  }
  variables {
    resource_type = "networksecuritygrouprule"
    resource_name = join("", [for i in range(81) : "a"])
  }
  expect_failures = [
    output.value
  ]
}

run "test_networksecuritygrouprule_fail_regex_start" {
  command = plan
  module {
    source = "../../azure/terraform-azurerm-resource-name-validation"
  }
  variables {
    resource_type = "networksecuritygrouprule"
    resource_name = "-nsg-rule-001"
  }
  expect_failures = [
    output.value
  ]
}

run "test_networksecuritygrouprule_fail_regex_end" {
  command = plan
  module {
    source = "../../azure/terraform-azurerm-resource-name-validation"
  }
  variables {
    resource_type = "networksecuritygrouprule"
    resource_name = "nsg-rule-001."
  }
  expect_failures = [
    output.value
  ]
}

run "test_privateendpoint_simple" {
  command = plan
  module {
    source = "../../azure/terraform-azurerm-resource-name-validation"
  }
  variables {
    resource_type = "privateendpoint"
    resource_name = "pe-test-001"
  }
}

run "test_privateendpoint_fail_min" {
  command = plan
  module {
    source = "../../azure/terraform-azurerm-resource-name-validation"
  }
  variables {
    resource_type = "privateendpoint"
    resource_name = "p"
  }
  expect_failures = [
    output.value
  ]
}

run "test_privateendpoint_fail_max" {
  command = plan
  module {
    source = "../../azure/terraform-azurerm-resource-name-validation"
  }
  variables {
    resource_type = "privateendpoint"
    resource_name = join("", [for i in range(65) : "a"])
  }
  expect_failures = [
    output.value
  ]
}

run "test_privateendpoint_fail_regex_start" {
  command = plan
  module {
    source = "../../azure/terraform-azurerm-resource-name-validation"
  }
  variables {
    resource_type = "privateendpoint"
    resource_name = "-pe-test-001"
  }
  expect_failures = [
    output.value
  ]
}

run "test_privateendpoint_fail_regex_end" {
  command = plan
  module {
    source = "../../azure/terraform-azurerm-resource-name-validation"
  }
  variables {
    resource_type = "privateendpoint"
    resource_name = "pe-test-001."
  }
  expect_failures = [
    output.value
  ]
}

run "test_publicip_simple" {
  command = plan
  module {
    source = "../../azure/terraform-azurerm-resource-name-validation"
  }
  variables {
    resource_type = "publicip"
    resource_name = "pip-test-001"
  }
}

run "test_publicip_fail_min" {
  command = plan
  module {
    source = "../../azure/terraform-azurerm-resource-name-validation"
  }
  variables {
    resource_type = "publicip"
    resource_name = ""
  }
  expect_failures = [
    output.value
  ]
}

run "test_publicip_fail_max" {
  command = plan
  module {
    source = "../../azure/terraform-azurerm-resource-name-validation"
  }
  variables {
    resource_type = "publicip"
    resource_name = join("", [for i in range(81) : "a"])
  }
  expect_failures = [
    output.value
  ]
}

run "test_publicip_fail_regex_start" {
  command = plan
  module {
    source = "../../azure/terraform-azurerm-resource-name-validation"
  }
  variables {
    resource_type = "publicip"
    resource_name = "-pip-test-001"
  }
  expect_failures = [
    output.value
  ]
}

run "test_publicip_fail_regex_end" {
  command = plan
  module {
    source = "../../azure/terraform-azurerm-resource-name-validation"
  }
  variables {
    resource_type = "publicip"
    resource_name = "pip-test-001."
  }
  expect_failures = [
    output.value
  ]
}

run "test_vpngateway_simple" {
  command = plan
  module {
    source = "../../azure/terraform-azurerm-resource-name-validation"
  }
  variables {
    resource_type = "vpngateway"
    resource_name = "vpngw-test-001"
  }
}

run "test_vpngateway_fail_min" {
  command = plan
  module {
    source = "../../azure/terraform-azurerm-resource-name-validation"
  }
  variables {
    resource_type = "vpngateway"
    resource_name = ""
  }
  expect_failures = [
    output.value
  ]
}

run "test_vpngateway_fail_max" {
  command = plan
  module {
    source = "../../azure/terraform-azurerm-resource-name-validation"
  }
  variables {
    resource_type = "vpngateway"
    resource_name = join("", [for i in range(81) : "a"])
  }
  expect_failures = [
    output.value
  ]
}

run "test_vpngateway_fail_regex_start" {
  command = plan
  module {
    source = "../../azure/terraform-azurerm-resource-name-validation"
  }
  variables {
    resource_type = "vpngateway"
    resource_name = "-vpngw-test-001"
  }
  expect_failures = [
    output.value
  ]
}

run "test_vpngateway_fail_regex_end" {
  command = plan
  module {
    source = "../../azure/terraform-azurerm-resource-name-validation"
  }
  variables {
    resource_type = "vpngateway"
    resource_name = "vpngw-test-001."
  }
  expect_failures = [
    output.value
  ]
}

run "test_servicebusnamespace_simple" {
  command = plan
  module {
    source = "../../azure/terraform-azurerm-resource-name-validation"
  }
  variables {
    resource_type = "servicebusnamespace"
    resource_name = "sbns-test-001"
  }
}

run "test_servicebusnamespace_fail_min" {
  command = plan
  module {
    source = "../../azure/terraform-azurerm-resource-name-validation"
  }
  variables {
    resource_type = "servicebusnamespace"
    resource_name = "sbns1"
  }
  expect_failures = [
    output.value
  ]
}

run "test_servicebusnamespace_fail_max" {
  command = plan
  module {
    source = "../../azure/terraform-azurerm-resource-name-validation"
  }
  variables {
    resource_type = "servicebusnamespace"
    resource_name = join("", [for i in range(51) : "a"])
  }
  expect_failures = [
    output.value
  ]
}

run "test_servicebusnamespace_fail_regex_start_digit" {
  command = plan
  module {
    source = "../../azure/terraform-azurerm-resource-name-validation"
  }
  variables {
    resource_type = "servicebusnamespace"
    resource_name = "1sbns-test-001"
  }
  expect_failures = [
    output.value
  ]
}

run "test_servicebusnamespace_fail_regex_end_hyphen" {
  command = plan
  module {
    source = "../../azure/terraform-azurerm-resource-name-validation"
  }
  variables {
    resource_type = "servicebusnamespace"
    resource_name = "sbns-test-001-"
  }
  expect_failures = [
    output.value
  ]
}

run "test_loganalyticsworkspace_simple" {
  command = plan
  module {
    source = "../../azure/terraform-azurerm-resource-name-validation"
  }
  variables {
    resource_type = "loganalyticsworkspace"
    resource_name = "law-test-001"
  }
}

run "test_loganalyticsworkspace_fail_min" {
  command = plan
  module {
    source = "../../azure/terraform-azurerm-resource-name-validation"
  }
  variables {
    resource_type = "loganalyticsworkspace"
    resource_name = "law"
  }
  expect_failures = [
    output.value
  ]
}

run "test_loganalyticsworkspace_fail_max" {
  command = plan
  module {
    source = "../../azure/terraform-azurerm-resource-name-validation"
  }
  variables {
    resource_type = "loganalyticsworkspace"
    resource_name = join("", [for i in range(64) : "a"])
  }
  expect_failures = [
    output.value
  ]
}

run "test_loganalyticsworkspace_fail_regex_start" {
  command = plan
  module {
    source = "../../azure/terraform-azurerm-resource-name-validation"
  }
  variables {
    resource_type = "loganalyticsworkspace"
    resource_name = "-law-test-001"
  }
  expect_failures = [
    output.value
  ]
}

run "test_loganalyticsworkspace_fail_regex_end" {
  command = plan
  module {
    source = "../../azure/terraform-azurerm-resource-name-validation"
  }
  variables {
    resource_type = "loganalyticsworkspace"
    resource_name = "law-test-001-"
  }
  expect_failures = [
    output.value
  ]
}

run "test_dnszone_simple" {
  command = plan
  module {
    source = "../../azure/terraform-azurerm-resource-name-validation"
  }
  variables {
    resource_type = "dnszone"
    resource_name = "example.com"
  }
}

run "test_dnszone_fail_min" {
  command = plan
  module {
    source = "../../azure/terraform-azurerm-resource-name-validation"
  }
  variables {
    resource_type = "dnszone"
    resource_name = ""
  }
  expect_failures = [
    output.value
  ]
}

run "test_dnszone_fail_max" {
  command = plan
  module {
    source = "../../azure/terraform-azurerm-resource-name-validation"
  }
  variables {
    resource_type = "dnszone"
    resource_name = join("", [for i in range(64) : "a"])
  }
  expect_failures = [
    output.value
  ]
}

run "test_dnszone_fail_regex_start" {
  command = plan
  module {
    source = "../../azure/terraform-azurerm-resource-name-validation"
  }
  variables {
    resource_type = "dnszone"
    resource_name = "-example.com"
  }
  expect_failures = [
    output.value
  ]
}

run "test_dnszone_fail_regex_end" {
  command = plan
  module {
    source = "../../azure/terraform-azurerm-resource-name-validation"
  }
  variables {
    resource_type = "dnszone"
    resource_name = "example.com."
  }
  expect_failures = [
    output.value
  ]
}

run "test_managedidentity_simple" {
  command = plan
  module {
    source = "../../azure/terraform-azurerm-resource-name-validation"
  }
  variables {
    resource_type = "managedidentity"
    resource_name = "mi-test-001"
  }
}

run "test_managedidentity_fail_min" {
  command = plan
  module {
    source = "../../azure/terraform-azurerm-resource-name-validation"
  }
  variables {
    resource_type = "managedidentity"
    resource_name = "mi"
  }
  expect_failures = [
    output.value
  ]
}

run "test_managedidentity_fail_max" {
  command = plan
  module {
    source = "../../azure/terraform-azurerm-resource-name-validation"
  }
  variables {
    resource_type = "managedidentity"
    resource_name = join("", [for i in range(129) : "a"])
  }
  expect_failures = [
    output.value
  ]
}

run "test_managedidentity_fail_regex" {
  command = plan
  module {
    source = "../../azure/terraform-azurerm-resource-name-validation"
  }
  variables {
    resource_type = "managedidentity"
    resource_name = ".mi-test-001"
  }
  expect_failures = [
    output.value
  ]
}

run "test_analysisservicesserver_simple" {
  command = plan
  module {
    source = "../../azure/terraform-azurerm-resource-name-validation"
  }
  variables {
    resource_type = "analysisservicesserver"
    resource_name = "asserver001"
  }
}

run "test_analysisservicesserver_fail_min" {
  command = plan
  module {
    source = "../../azure/terraform-azurerm-resource-name-validation"
  }
  variables {
    resource_type = "analysisservicesserver"
    resource_name = "as"
  }
  expect_failures = [
    output.value
  ]
}

run "test_analysisservicesserver_fail_max" {
  command = plan
  module {
    source = "../../azure/terraform-azurerm-resource-name-validation"
  }
  variables {
    resource_type = "analysisservicesserver"
    resource_name = join("", [for i in range(64) : "a"])
  }
  expect_failures = [
    output.value
  ]
}

run "test_analysisservicesserver_fail_regex_uppercase" {
  command = plan
  module {
    source = "../../azure/terraform-azurerm-resource-name-validation"
  }
  variables {
    resource_type = "analysisservicesserver"
    resource_name = "AsServer001"
  }
  expect_failures = [
    output.value
  ]
}

run "test_analysisservicesserver_fail_regex_start_digit" {
  command = plan
  module {
    source = "../../azure/terraform-azurerm-resource-name-validation"
  }
  variables {
    resource_type = "analysisservicesserver"
    resource_name = "1asserver001"
  }
  expect_failures = [
    output.value
  ]
}

run "test_computegallery_simple" {
  command = plan
  module {
    source = "../../azure/terraform-azurerm-resource-name-validation"
  }
  variables {
    resource_type = "computegallery"
    resource_name = "MyGallery001"
  }
}

run "test_computegallery_fail_min" {
  command = plan
  module {
    source = "../../azure/terraform-azurerm-resource-name-validation"
  }
  variables {
    resource_type = "computegallery"
    resource_name = ""
  }
  expect_failures = [
    output.value
  ]
}

run "test_computegallery_fail_max" {
  command = plan
  module {
    source = "../../azure/terraform-azurerm-resource-name-validation"
  }
  variables {
    resource_type = "computegallery"
    resource_name = join("", [for i in range(81) : "a"])
  }
  expect_failures = [
    output.value
  ]
}

run "test_computegallery_fail_regex_hyphen" {
  command = plan
  module {
    source = "../../azure/terraform-azurerm-resource-name-validation"
  }
  variables {
    resource_type = "computegallery"
    resource_name = "my-gallery-001"
  }
  expect_failures = [
    output.value
  ]
}

run "test_computegalleryimage_simple" {
  command = plan
  module {
    source = "../../azure/terraform-azurerm-resource-name-validation"
  }
  variables {
    resource_type = "computegalleryimage"
    resource_name = "my-gallery-image-001"
  }
}

run "test_computegalleryimage_fail_min" {
  command = plan
  module {
    source = "../../azure/terraform-azurerm-resource-name-validation"
  }
  variables {
    resource_type = "computegalleryimage"
    resource_name = ""
  }
  expect_failures = [
    output.value
  ]
}

run "test_computegalleryimage_fail_max" {
  command = plan
  module {
    source = "../../azure/terraform-azurerm-resource-name-validation"
  }
  variables {
    resource_type = "computegalleryimage"
    resource_name = join("", [for i in range(81) : "a"])
  }
  expect_failures = [
    output.value
  ]
}

run "test_computegalleryimage_fail_regex_start" {
  command = plan
  module {
    source = "../../azure/terraform-azurerm-resource-name-validation"
  }
  variables {
    resource_type = "computegalleryimage"
    resource_name = "-my-gallery-image-001"
  }
  expect_failures = [
    output.value
  ]
}

run "test_computegalleryimage_fail_regex_end" {
  command = plan
  module {
    source = "../../azure/terraform-azurerm-resource-name-validation"
  }
  variables {
    resource_type = "computegalleryimage"
    resource_name = "my-gallery-image-001."
  }
  expect_failures = [
    output.value
  ]
}

run "test_userassignedidentity_simple" {
  command = plan
  module {
    source = "../../azure/terraform-azurerm-resource-name-validation"
  }
  variables {
    resource_type = "userassignedidentity"
    resource_name = "uai-test-001"
  }
}

run "test_userassignedidentity_fail_min" {
  command = plan
  module {
    source = "../../azure/terraform-azurerm-resource-name-validation"
  }
  variables {
    resource_type = "userassignedidentity"
    resource_name = "ua"
  }
  expect_failures = [
    output.value
  ]
}

run "test_userassignedidentity_fail_max" {
  command = plan
  module {
    source = "../../azure/terraform-azurerm-resource-name-validation"
  }
  variables {
    resource_type = "userassignedidentity"
    resource_name = join("", [for i in range(129) : "a"])
  }
  expect_failures = [
    output.value
  ]
}

run "test_userassignedidentity_fail_regex" {
  command = plan
  module {
    source = "../../azure/terraform-azurerm-resource-name-validation"
  }
  variables {
    resource_type = "userassignedidentity"
    resource_name = ".uai-test-001"
  }
  expect_failures = [
    output.value
  ]
}


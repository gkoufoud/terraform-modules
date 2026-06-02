# https://learn.microsoft.com/en-us/azure/azure-resource-manager/management/resource-name-rules
locals {

  min_length = (
    lower(var.resource_type) == "aks" ? 3 :
    lower(var.resource_type) == "aksagentpool" ? 3 :
    lower(var.resource_type) == "resourcegroup" ? 1 :
    lower(var.resource_type) == "vm_windows" ? 1 :
    lower(var.resource_type) == "vm_linux" ? 1 :
    lower(var.resource_type) == "vmss_windows" ? 1 :
    lower(var.resource_type) == "vmss_linux" ? 1 :
    lower(var.resource_type) == "acr" ? 5 :
    lower(var.resource_type) == "vnet" ? 1 :
    lower(var.resource_type) == "keyvault" ? 3 :
    lower(var.resource_type) == "loadbalancer" ? 1 :
    lower(var.resource_type) == "storageaccount" ? 3 :
    lower(var.resource_type) == "storageaccountcontainer" ? 3 :
    lower(var.resource_type) == "fileshare" ? 3 :
    lower(var.resource_type) == "postgresqlserver" ? 3 :
    lower(var.resource_type) == "postgresqldb" ? 1 :
    lower(var.resource_type) == "networksecuritygroup" ? 1 :
    lower(var.resource_type) == "networksecuritygrouprule" ? 1 :
    lower(var.resource_type) == "privateendpoint" ? 2 :
    lower(var.resource_type) == "publicip" ? 1 :
    lower(var.resource_type) == "vpngateway" ? 1 :
    lower(var.resource_type) == "servicebusnamespace" ? 6 :
    lower(var.resource_type) == "loganalyticsworkspace" ? 4 :
    lower(var.resource_type) == "dnszone" ? 1 :
    lower(var.resource_type) == "managedidentity" ? 3 :
    lower(var.resource_type) == "analysisservicesserver" ? 3 :
    lower(var.resource_type) == "computegallery" ? 1 :
    lower(var.resource_type) == "computegalleryimage" ? 1 :
    lower(var.resource_type) == "userassignedidentity" ? 3 :
    0
  )

  max_length = (
    lower(var.resource_type) == "aks" ? 30 :
    lower(var.resource_type) == "aksagentpool" ? 30 :
    lower(var.resource_type) == "resourcegroup" ? 90 :
    lower(var.resource_type) == "vm_windows" ? 15 :
    lower(var.resource_type) == "vm_linux" ? 64 :
    lower(var.resource_type) == "vmss_windows" ? 15 :
    lower(var.resource_type) == "vmss_linux" ? 64 :
    lower(var.resource_type) == "acr" ? 50 :
    lower(var.resource_type) == "vnet" ? 80 :
    lower(var.resource_type) == "keyvault" ? 24 :
    lower(var.resource_type) == "loadbalancer" ? 80 :
    lower(var.resource_type) == "storageaccount" ? 24 :
    lower(var.resource_type) == "storageaccountcontainer" ? 63 :
    lower(var.resource_type) == "fileshare" ? 63 :
    lower(var.resource_type) == "postgresqlserver" ? 63 :
    lower(var.resource_type) == "postgresqldb" ? 63 :
    lower(var.resource_type) == "networksecuritygroup" ? 80 :
    lower(var.resource_type) == "networksecuritygrouprule" ? 80 :
    lower(var.resource_type) == "privateendpoint" ? 64 :
    lower(var.resource_type) == "publicip" ? 80 :
    lower(var.resource_type) == "vpngateway" ? 80 :
    lower(var.resource_type) == "servicebusnamespace" ? 50 :
    lower(var.resource_type) == "loganalyticsworkspace" ? 63 :
    lower(var.resource_type) == "dnszone" ? 63 :
    lower(var.resource_type) == "managedidentity" ? 128 :
    lower(var.resource_type) == "analysisservicesserver" ? 63 :
    lower(var.resource_type) == "computegallery" ? 80 :
    lower(var.resource_type) == "computegalleryimage" ? 80 :
    lower(var.resource_type) == "userassignedidentity" ? 128 :
    128
  )

  regex_pattern = (
    lower(var.resource_type) == "aks" ? "^[a-zA-Z0-9][a-zA-Z0-9-_.]*[a-zA-Z0-9]$" :
    lower(var.resource_type) == "aksagentpool" ? "^[a-zA-Z0-9][a-zA-Z0-9-_.]*[a-zA-Z0-9]$" :
    lower(var.resource_type) == "resourcegroup" ? "^[a-zA-Z0-9_](?:[a-zA-Z0-9_.()-]{0,88}[a-zA-Z0-9_])?$" :
    lower(var.resource_type) == "vm_windows" ? "^[a-zA-Z0-9](?:[a-zA-Z0-9-]*[a-zA-Z0-9])?$" :
    lower(var.resource_type) == "vm_linux" ? "^[a-zA-Z0-9](?:[a-zA-Z0-9-]*[a-zA-Z0-9])?$" :
    lower(var.resource_type) == "vmss_windows" ? "^[a-zA-Z0-9](?:[a-zA-Z0-9-]*[a-zA-Z0-9])?$" :
    lower(var.resource_type) == "vmss_linux" ? "^[a-zA-Z0-9](?:[a-zA-Z0-9-]*[a-zA-Z0-9])?$" :
    lower(var.resource_type) == "acr" ? "^[a-zA-Z0-9]+$" :
    lower(var.resource_type) == "vnet" ? "^[a-zA-Z0-9](?:[a-zA-Z0-9_.-]*[a-zA-Z0-9_])?$" :
    lower(var.resource_type) == "keyvault" ? "^(?!.*--)[a-zA-Z][a-zA-Z0-9-]*[a-zA-Z0-9]$" :
    lower(var.resource_type) == "loadbalancer" ? "^[a-zA-Z0-9](?:[a-zA-Z0-9_.-]*[a-zA-Z0-9_])?$" :
    lower(var.resource_type) == "storageaccount" ? "^[a-z0-9]{3,24}$" :
    lower(var.resource_type) == "storageaccountcontainer" ? "^(?!.*--)[a-z0-9][a-z0-9-]*[a-z0-9]$" :
    lower(var.resource_type) == "fileshare" ? "^(?!.*--)[a-z0-9][a-z0-9-]*[a-z0-9]$" :
    lower(var.resource_type) == "postgresqlserver" ? "^(?!.*--)[a-z0-9][a-z0-9-]*[a-z0-9]$" :
    lower(var.resource_type) == "postgresqldb" ? "^[a-zA-Z0-9](?:[a-zA-Z0-9-]*[a-zA-Z0-9])?$" :
    lower(var.resource_type) == "networksecuritygroup" ? "^[a-zA-Z0-9](?:[a-zA-Z0-9_.-]*[a-zA-Z0-9_])?$" :
    lower(var.resource_type) == "networksecuritygrouprule" ? "^[a-zA-Z0-9](?:[a-zA-Z0-9_.-]*[a-zA-Z0-9_])?$" :
    lower(var.resource_type) == "privateendpoint" ? "^[a-zA-Z0-9](?:[a-zA-Z0-9_.-]*[a-zA-Z0-9_])?$" :
    lower(var.resource_type) == "publicip" ? "^[a-zA-Z0-9](?:[a-zA-Z0-9_.-]*[a-zA-Z0-9_])?$" :
    lower(var.resource_type) == "vpngateway" ? "^[a-zA-Z0-9](?:[a-zA-Z0-9_.-]*[a-zA-Z0-9_])?$" :
    lower(var.resource_type) == "servicebusnamespace" ? "^[a-zA-Z][a-zA-Z0-9-]*[a-zA-Z0-9]$" :
    lower(var.resource_type) == "loganalyticsworkspace" ? "^[a-zA-Z0-9][a-zA-Z0-9-]*[a-zA-Z0-9]$" :
    lower(var.resource_type) == "dnszone" ? "^[a-zA-Z0-9](?:[a-zA-Z0-9_.-]*[a-zA-Z0-9])?$" :
    lower(var.resource_type) == "managedidentity" ? "^[a-zA-Z0-9][a-zA-Z0-9_-]*$" :
    lower(var.resource_type) == "analysisservicesserver" ? "^[a-z][a-z0-9]*$" :
    lower(var.resource_type) == "computegallery" ? "^[a-zA-Z0-9](?:[a-zA-Z0-9_.]*[a-zA-Z0-9])?$" :
    lower(var.resource_type) == "computegalleryimage" ? "^[a-zA-Z0-9](?:[a-zA-Z0-9_.-]*[a-zA-Z0-9])?$" :
    lower(var.resource_type) == "userassignedidentity" ? "^[a-zA-Z0-9][a-zA-Z0-9_-]*$" :
    ".*"
  )

  error_message_details = (
    lower(var.resource_type) == "aks" ? "It can only contain alphanumerics, underscores, and hyphens, and must start and end with an alphanumeric character." :
    lower(var.resource_type) == "aksagentpool" ? "It can use only lowercase letters and numbers, and must start with a letter." :
    lower(var.resource_type) == "resourcegroup" ? "It can contain alphanumerics, underscores, periods, hyphens, and parentheses, must start with an alphanumeric character, and can't end with a period." :
    lower(var.resource_type) == "vm_windows" ? "It can't use spaces, control characters, or these characters: ~ ! @ # $ % ^ & * ( ) = + _ [ ] { } \\ | ; : . ' \" , < > / ?. It can't end with a hyphen." :
    lower(var.resource_type) == "vm_linux" ? "It can't use spaces, control characters, or these characters: ~ ! @ # $ % ^ & * ( ) = + _ [ ] { } \\ | ; : . ' \" , < > / ?. It can't end with a period or hyphen." :
    lower(var.resource_type) == "vmss_windows" ? "It can't use spaces, control characters, or these characters: ~ ! @ # $ % ^ & * ( ) = + _ [ ] { } \\ | ; : . ' \" , < > / ?. It can't start with an underscore and can't end with a period or hyphen." :
    lower(var.resource_type) == "vmss_linux" ? "It can't use spaces, control characters, or these characters: ~ ! @ # $ % ^ & * ( ) = + _ [ ] { } \\ | ; : . ' \" , < > / ?. It can't start with an underscore and can't end with a period or hyphen." :
    lower(var.resource_type) == "acr" ? "It can use only alphanumeric characters." :
    lower(var.resource_type) == "vnet" ? "It can contain alphanumerics, underscores, periods, and hyphens, must start with an alphanumeric character, and must end with an alphanumeric character or underscore." :
    lower(var.resource_type) == "keyvault" ? "It can contain alphanumerics and hyphens, must start with a letter, must end with a letter or number, and can't contain consecutive hyphens." :
    lower(var.resource_type) == "loadbalancer" ? "It can contain alphanumerics, underscores, periods, and hyphens, must start with an alphanumeric character, and must end with an alphanumeric character or underscore." :
    lower(var.resource_type) == "storageaccount" ? "It can use only lowercase letters and numbers." :
    lower(var.resource_type) == "storageaccountcontainer" ? "It can use only lowercase letters, numbers, and hyphens, can't start or end with a hyphen, and can't contain consecutive hyphens." :
    lower(var.resource_type) == "fileshare" ? "It can use only lowercase letters, numbers, and hyphens, can't start or end with a hyphen, and can't contain consecutive hyphens." :
    lower(var.resource_type) == "postgresqlserver" ? "It can use only lowercase letters, numbers, and hyphens, and can't start or end with a hyphen." :
    lower(var.resource_type) == "postgresqldb" ? "It can contain alphanumerics and hyphens." :
    lower(var.resource_type) == "networksecuritygroup" ? "It can contain alphanumerics, underscores, periods, and hyphens, must start with an alphanumeric character, and must end with an alphanumeric character or underscore." :
    lower(var.resource_type) == "networksecuritygrouprule" ? "It can contain alphanumerics, underscores, periods, and hyphens, must start with an alphanumeric character, and must end with an alphanumeric character or underscore." :
    lower(var.resource_type) == "privateendpoint" ? "It can contain alphanumerics, underscores, periods, and hyphens, must start with an alphanumeric character, and must end with an alphanumeric character or underscore." :
    lower(var.resource_type) == "publicip" ? "It can contain alphanumerics, underscores, periods, and hyphens, must start with an alphanumeric character, and must end with an alphanumeric character or underscore." :
    lower(var.resource_type) == "vpngateway" ? "It can contain alphanumerics, underscores, periods, and hyphens, must start with an alphanumeric character, and must end with an alphanumeric character or underscore." :
    lower(var.resource_type) == "servicebusnamespace" ? "It can contain alphanumerics and hyphens, must start with a letter, and must end with a letter or number." :
    lower(var.resource_type) == "loganalyticsworkspace" ? "It can contain alphanumerics and hyphens, and must start and end with an alphanumeric character." :
    lower(var.resource_type) == "dnszone" ? "It must have 2 to 34 labels separated by periods. Each label can contain alphanumerics, underscores, and hyphens." :
    lower(var.resource_type) == "managedidentity" ? "It can contain alphanumerics, hyphens, and underscores, and must start with a letter or number." :
    lower(var.resource_type) == "analysisservicesserver" ? "It must use only lowercase letters and numbers, and start with a lowercase letter." :
    lower(var.resource_type) == "computegallery" ? "It can contain alphanumerics, underscores, and periods, and must start and end with an alphanumeric character." :
    lower(var.resource_type) == "computegalleryimage" ? "It can contain alphanumerics, underscores, hyphens, and periods, and must start and end with an alphanumeric character." :
    lower(var.resource_type) == "userassignedidentity" ? "It can contain alphanumerics, hyphens, and underscores, and must start with a letter or number." :
    "It doesn't match the naming rules for the selected resource type."
  )
}
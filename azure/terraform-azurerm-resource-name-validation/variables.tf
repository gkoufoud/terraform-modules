variable "resource_type" {
  description = "The type of the resource to create/check the name for. E.g. 'acr'"
  type        = string
  validation {
    condition = contains([
      "resourcegroup",
      "vm_windows",
      "vm_linux",
      "vmss_windows",
      "vmss_linux",
      "acr",
      "vnet",
      "aks",
      "aksagentpool",
      "keyvault",
      "loadbalancer",
      "storageaccount",
      "storageaccountcontainer",
      "fileshare",
      "postgresqlserver",
      "postgresqldb",
      "networksecuritygroup",
      "networksecuritygrouprule",
      "privateendpoint",
      "publicip",
      "vpngateway",
      "servicebusnamespace",
      "loganalyticsworkspace",
      "dnszone",
      "managedidentity",
      "analysisservicesserver",
      "computegallery",
      "computegalleryimage",
      "userassignedidentity",
    ], lower(var.resource_type))
    error_message = "Invalid resource type. Must be one of: 'resourcegroup', 'vm_windows', 'vm_linux', 'vmss_windows', 'vmss_linux', 'acr', 'vnet', 'aks', 'aksagentpool', 'keyvault', 'loadbalancer', 'storageaccount', 'storageaccountcontainer', 'fileshare', 'postgresqlserver', 'postgresqldb', 'networksecuritygroup', 'networksecuritygrouprule', 'privateendpoint', 'publicip', 'vpngateway', 'servicebusnamespace', 'loganalyticsworkspace', 'dnszone', 'managedidentity', 'analysisservicesserver', 'computegallery', 'computegalleryimage', 'userassignedidentity'."
  }
}

variable "resource_name" {
  description = "The full name of the resource. If provided, this will be used instead of generating a name from the prefix, resource type, and suffix."
  type        = string
  default     = ""
}

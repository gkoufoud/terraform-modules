output "public_dns_zones" {
  value = {
    for key, zone in azurerm_dns_zone.public_zone :
    key => zone
  }
  description = "The public DNS zones"
}

output "private_dns_zones" {
  value = {
    for key, zone in azurerm_private_dns_zone.private_zone :
    key => zone
  }
  description = "The private DNS zones"
}

output "public_dns_zones_dnssec" {
  value = {
    for key, dnssec in azapi_resource.public_zone_dnssec :
    key => dnssec
  }
  description = "The public DNS zones DNSSEC configurations"
}

output "vnet_links" {
  value = {
    for key, link in azurerm_private_dns_zone_virtual_network_link.vnet_link :
    key => link
  }
  description = "The private DNS zones virtual network links"
}

output "public_a_records" {
  value = {
    for key, record in azurerm_dns_a_record.public_a_record :
    key => record
  }
  description = "The public A records"
}

output "private_a_records" {
  value = {
    for key, record in azurerm_private_dns_a_record.private_a_record :
    key => record
  }
  description = "The private A records"
}

output "public_cname_records" {
  value = {
    for key, record in azurerm_dns_cname_record.public_cname_record :
    key => record
  }
  description = "The public CNAME records"
}

output "private_cname_records" {
  value = {
    for key, record in azurerm_private_dns_cname_record.private_cname_record :
    key => record
  }
  description = "The private CNAME records"
}

output "public_mx_records" {
  value = {
    for key, record in azurerm_dns_mx_record.public_mx_record :
    key => record
  }
  description = "The public MX records"
}

output "private_mx_records" {
  value = {
    for key, record in azurerm_private_dns_mx_record.private_mx_record :
    key => record
  }
  description = "The private MX records"
}

output "ns_records" {
  value = {
    for key, record in azurerm_dns_ns_record.ns_record :
    key => record
  }
  description = "The public NS records"
}

output "caa_records" {
  value = {
    for key, record in azurerm_dns_caa_record.caa_record :
    key => record
  }
  description = "The public CAA records"
}

output "public_ptr_records" {
  value = {
    for key, record in azurerm_dns_ptr_record.public_ptr_record :
    key => record
  }
  description = "The public PTR records"
}

output "private_ptr_records" {
  value = {
    for key, record in azurerm_private_dns_ptr_record.private_ptr_record :
    key => record
  }
  description = "The private PTR records"
}

output "public_srv_records" {
  value = {
    for key, record in azurerm_dns_srv_record.public_srv_record :
    key => record
  }
  description = "The public SRV records"
}

output "private_srv_records" {
  value = {
    for key, record in azurerm_private_dns_srv_record.private_srv_record :
    key => record
  }
  description = "The private SRV records"
}

output "public_txt_records" {
  value = {
    for key, record in azurerm_dns_txt_record.public_txt_record :
    key => record
  }
  description = "The public TXT records"
}

output "private_txt_records" {
  value = {
    for key, record in azurerm_private_dns_txt_record.private_txt_record :
    key => record
  }
  description = "The private TXT records"
}

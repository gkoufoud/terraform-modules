#!/bin/bash

set -eETo pipefail

failure() {
  local lineno="$1"
  local msg="$2"
  echo "Failed at $lineno: $msg"
}
trap 'failure ${LINENO} "$BASH_COMMAND" $?' ERR

terraform init -upgrade=true
terraform test -filter terraform-azapi-get-resources.tftest.hcl
terraform test -filter terraform-azurerm-dns.tftest.hcl
terraform test -filter terraform-azurerm-get-keyvault-secret.tftest.hcl


# terraform test -verbose -filter test1.tftest.hcl

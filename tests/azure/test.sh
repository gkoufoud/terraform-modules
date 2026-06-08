#!/bin/bash

set -eETo pipefail

failure() {
  local lineno="$1"
  local msg="$2"
  echo "Failed at $lineno: $msg"
}
trap 'failure ${LINENO} "$BASH_COMMAND" $?' ERR

cd "$(dirname "$0")"
terraform init -upgrade=true
terraform test

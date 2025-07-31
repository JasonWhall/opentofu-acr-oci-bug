#!/bin/bash

# Script to publish a module to Azure Container Registry (ACR)
# Usage: ./publish-module.sh <acr-name>

set -eou pipefail

if [ -z "$1" ]; then
  echo "Usage: $0 <acr_name>"
  exit 1
fi

ACR_NAME="$1"

echo "Building module package..."

zip -r modules.zip modules/example

echo "Pushing module to Azure Container Registry '$ACR_NAME'..."

az acr login --name "$ACR_NAME"

oras push \
  --artifact-type=application/vnd.opentofu.modulepkg \
   "$ACR_NAME.azurecr.io/example-module:latest" \
   modules.zip:archive/zip
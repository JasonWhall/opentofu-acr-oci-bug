#!/bin/bash

# Script to create an Azure Container Registry (ACR) instance
# Usage: ./create-acr.sh <acr-name> <resource-group>

set -eou pipefail

if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <acr-name> <resource-group>"
    exit 1
fi

ACR_NAME="$1"
RESOURCE_GROUP="$2"
LOCATION="westeurope" # Change as needed

az group create \
    --name $RESOURCE_GROUP \
    --location "$LOCATION"

echo "Creating Azure Container Registry '$ACR_NAME' in resource group '$RESOURCE_GROUP'..."

az acr create \
    --name $ACR_NAME \
    --resource-group "$RESOURCE_GROUP" \
    --sku Standard \
    --location $LOCATION \
    --admin-enabled true

echo "ACR '$ACR_NAME' created successfully."
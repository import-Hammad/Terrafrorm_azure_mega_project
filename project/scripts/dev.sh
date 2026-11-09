#!/bin/bash

RESOURCE_GROUP_NAME=terraform-state-rg
STAGE_SA_ACCOUNT=tfstagebackendhammad2026
DEV_SA_ACCOUNT=tfdevbackendhammad2026
CONTAINER_NAME=tfstate

# Create resource group
az group create --name $RESOURCE_GROUP_NAME --location canadacentral

# Create storage account for staging environment
az storage account create \
  --resource-group $RESOURCE_GROUP_NAME \
  --name $STAGE_SA_ACCOUNT \
  --sku Standard_LRS \
  --encryption-services blob \
  --https-only true \
  --min-tls-version TLS1_2

# Create storage account for dev environment
az storage account create \
  --resource-group $RESOURCE_GROUP_NAME \
  --name $DEV_SA_ACCOUNT \
  --sku Standard_LRS \
  --encryption-services blob \
  --https-only true \
  --min-tls-version TLS1_2

# Create blob container for staging environment
az storage container create --name $CONTAINER_NAME --account-name $STAGE_SA_ACCOUNT --auth-mode login

# Create blob container for dev environment
az storage container create --name $CONTAINER_NAME --account-name $DEV_SA_ACCOUNT --auth-mode login

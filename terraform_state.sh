#!/bin/bash

ENV="PROD"
PROJECT_NAME="its-crm"
RESOURCE_GROUP_NAME="rg-icprod-its-crm"
STORAGE_ACCOUNT_NAME="sticprodcrm"
CONTAINER_NAME="tfstate"

# Create resource group
# az group create --name $RESOURCE_GROUP_NAME --location eastus

# Create storage account
az storage account create --resource-group $RESOURCE_GROUP_NAME --name $STORAGE_ACCOUNT_NAME --sku Standard_LRS --encryption-services blob --tags Environment=$ENV

# Create blob container
az storage container create --name $CONTAINER_NAME --account-name $STORAGE_ACCOUNT_NAME
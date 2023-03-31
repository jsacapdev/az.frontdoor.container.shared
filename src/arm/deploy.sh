#!/bin/sh
set -e

echo "Resource Group: $1";
echo "Deployment Name: $2";
echo "Location: $3";

RESOURCE_GROUP_NAME=$1
DEPLOYMENT_NAME=$2
LOCATION=$3

# workaround to get bicep to work with azure cli github action
az config set bicep.use_binary_from_path=false
az bicep install

RESULT=$(az deployment group create \
    --resource-group $RESOURCE_GROUP_NAME \
    --name $DEPLOYMENT_NAME \
    --template-file ./main.bicep \
    --parameters location=$LOCATION \
    --query properties.outputs.result)

# exit 1

echo Finshed.

#!/bin/sh
set -e

echo "Parameters..."
echo "Resource Group -> $1";
echo "Deployment Name -> $2";
echo "Location -> $3";
echo "Workspace -> $4";

RESOURCE_GROUP_NAME=$1
DEPLOYMENT_NAME=$2
LOCATION=$3
WORKSPACE=$4
ADMIN_USERNAME=$5
ADMIN_PASSWORD=$6

# workaround to get bicep to work with azure cli github action
az config set bicep.use_binary_from_path=false
az bicep install

result=$(az deployment group create \
    --resource-group $RESOURCE_GROUP_NAME \
    --name $DEPLOYMENT_NAME \
    --template-file $WORKSPACE/main.bicep \
    --parameters \
    location=$LOCATION \
    adminUsername=$ADMIN_USERNAME \
    adminPassword=$ADMIN_PASSWORD \
    -o json \
    --query properties.correlationId)

echo "Finshed."

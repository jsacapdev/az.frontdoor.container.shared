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

RESULT=$(az deployment group create \
    --resource-group $RESOURCE_GROUP_NAME \
    --name $DEPLOYMENT_NAME \
    --template-file $WORKSPACE/main.bicep \
    --parameters location=$LOCATION \
    --query properties.outputs.result)

echo Finshed.

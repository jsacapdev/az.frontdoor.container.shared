@description('The location into which the resources should be deployed.')
param location string

@description('The storage account name.')
param vmStorageAccountName string 

resource vmStg 'Microsoft.Storage/storageAccounts@2022-05-01' = {
  name: vmStorageAccountName
  location: location
  kind: 'StorageV2'
  sku: {
    name: 'Standard_LRS'
  }
}

output vmStorageAccountBlobPrimaryEndpoint string = vmStg.properties.primaryEndpoints.blob

@description('The location into which the resources should be deployed.')
param location string

@description('Name')
param vnetName string

@description('Name')
param peSubnetName string

@description('.')
param keyVaultName string

@description('.')
param kvPrivateDnsZoneNameNameId string

// local variables
var keyVaultAppPrivateEndpointName = 'pe-${keyVaultName}'

resource keyVault 'Microsoft.KeyVault/vaults@2022-07-01' existing = {
  name: keyVaultName
}

resource kvPrivateEndpoint 'Microsoft.Network/privateEndpoints@2022-05-01' = {
  name: keyVaultAppPrivateEndpointName
  location: location
  properties: {
    privateLinkServiceConnections: [
      {
        name: keyVaultAppPrivateEndpointName
        properties: {
          privateLinkServiceId: keyVault.id
          groupIds: [
            'vault'
          ]
        }
      }
    ]
    subnet: {
      id: resourceId('Microsoft.Network/virtualNetworks/subnets', vnetName, peSubnetName)
    }
  }
}

resource kvPrivateEndpointGroup 'Microsoft.Network/privateEndpoints/privateDnsZoneGroups@2022-05-01' = {
  parent: kvPrivateEndpoint
  name: 'default'
  properties: {
    privateDnsZoneConfigs: [
      {
        name: 'config1'
        properties: {
          privateDnsZoneId: kvPrivateDnsZoneNameNameId
        }
      }
    ]
  }
}

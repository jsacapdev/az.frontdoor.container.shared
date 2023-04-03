@description('Name')
param vnetName string

@description('Name')
param vmSubnetName string

@description('Name')
param kvSubnetName string

@description('.')
param publicIpName string

@description('.')
param nsgName string

@description('.')
param nicName string

@description('The location.')
param location string

resource pip 'Microsoft.Network/publicIPAddresses@2022-05-01' = {
  name: publicIpName
  location: location
  sku: {
    name: 'Basic'
  }
  properties: {
    publicIPAllocationMethod: 'dynamic'
    dnsSettings: {
      domainNameLabel: publicIpName
    }
  }
}

resource securityGroup 'Microsoft.Network/networkSecurityGroups@2022-05-01' = {
  name: nsgName
  location: location
  properties: {
    securityRules: [
      {
        name: 'default-allow-3389'
        properties: {
          priority: 1000
          access: 'Allow'
          direction: 'Inbound'
          destinationPortRange: '3389'
          protocol: 'Tcp'
          sourcePortRange: '*'
          sourceAddressPrefix: '*'
          destinationAddressPrefix: '*'
        }
      }
    ]
  }
}

resource virtualNetwork 'Microsoft.Network/virtualNetworks@2022-05-01' = {
  name: vnetName
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.1.0.0/16'
      ]
    }
    subnets: [
      {
        name: vmSubnetName
        properties: {
          addressPrefix: '10.1.0.0/26'
          networkSecurityGroup: {
            id: securityGroup.id
          }
        }
      }
    ]
  }
}

resource nic 'Microsoft.Network/networkInterfaces@2022-05-01' = {
  name: nicName
  location: location
  properties: {
    ipConfigurations: [
      {
        name: 'ipconfig1'
        properties: {
          privateIPAllocationMethod: 'dynamic'
          publicIPAddress: {
            id: pip.id
          }
          subnet: {
            id: resourceId('Microsoft.Network/virtualNetworks/subnets', virtualNetwork.name, vmSubnetName)
          }
        }
      }
    ]
  }
}

output nicId string = nic.id

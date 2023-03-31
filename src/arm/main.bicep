@minLength(3)
@maxLength(8)
@description('The environment name.')
param environment string = 'dev'

@minLength(1)
@maxLength(20)
@description('The location.')
param location string

@description('Username for the Virtual Machine.')
@secure()
param adminUsername string

@description('Password for the Virtual Machine.')
@minLength(12)
@secure()
param adminPassword string

//////////////////////
// global variables 
//////////////////////

// product name
var product = 'ca'

// network
var vnetName = 'vnet-${product}-${environment}-001'
var vmSubnetName = 'snet-${product}-${environment}-001'
var kvSubnetName = 'snet-${product}-${environment}-002'

// vm
var vmStorageAccountName = 'st${product}${environment}001'
var publicIpName = 'pip-${product}-${environment}-001'
var nsgName = 'nsg-${product}-${environment}-001'
var nicName = 'nic-${product}-${environment}-001'
var vmName = 'vm${product}${environment}001'
var keyVaultName = 'kv-${product}-${environment}-001'

module stg './modules/storage.bicep' = {
  name: 'storageDeploy'
  params: {
    location: location
    vmStorageAccountName: vmStorageAccountName
  }
}

// module network './network.bicep' = {
//   name: 'network'
//   params: {
//     location: location
//     vnetName: vnetName
//     vmSubnetName: vmSubnetName
//     kvSubnetName: kvSubnetName
//     publicIpName: publicIpName
//     nsgName: nsgName
//     nicName: nicName
//   }
// }

// module dns './dns.bicep' = {
//   name: 'dns'
//   dependsOn: [
//     network
//   ]
//   params: {
//     vnetName: vnetName
//   }
// }

// module vm './vm.bicep' = {
//   name: 'vmDeploy'
//   dependsOn: [
//     network
//     stg
//   ]
//   params: {
//     location: location
//     vmName: vmName
//     nicId: network.outputs.nicId
//     vmStorageAccountBlobPrimaryEndpoint: stg.outputs.vmStorageAccountBlobPrimaryEndpoint
//     adminUsername: adminUsername
//     adminPassword: adminPassword
//   }
// }

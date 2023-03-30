param name string
param location string = 'uksouth'
param tags object = {}
param private_endpoint_blob_name string
param subnet_id string

@allowed([
  'Standard_LRS'
  'Standard_GRS'
  'Standard_ZRS'
])
param sku_name string = 'Standard_LRS'


resource storage_account 'Microsoft.Storage/storageAccounts@2021-02-01' = {
  name: name
  location: location
  kind: 'StorageV2'
  tags: tags
  sku: {
    name: sku_name
  }
  properties: {
    accessTier: 'Hot'
    supportsHttpsTrafficOnly: true
    allowBlobPublicAccess: false
  }
}


resource private_endpoint_blob 'Microsoft.Network/privateEndpoints@2022-01-01' = {
  name: private_endpoint_blob_name
  location: location
  tags: tags
  properties: {
    privateLinkServiceConnections: [
      { 
        name: private_endpoint_blob_name
        properties: {
          groupIds: [
            'blob'
          ]
          privateLinkServiceId: storage_account.id
          privateLinkServiceConnectionState: {
            status: 'Approved'
            description: 'Auto-Approved'
            actionsRequired: 'None'
          }
        }
      }
    ]
    subnet: {
      id: subnet_id
    }
  }
}

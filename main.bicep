param name string = 'saiygiuyg123'
param location string = 'uksouth'

@allowed([
  'Standard_LRS'
  'Standard_GRS'
  'Standard_ZRS'
])
param sku_name string = 'Standard_LRS'

resource name_resource 'Microsoft.Storage/storageAccounts@2021-02-01' = {
  name: name
  location: location
  kind: 'StorageV2'
  sku: {
    name: sku_name
  }
  properties: {
    accessTier: 'Hot'
    supportsHttpsTrafficOnly: true
  }
}
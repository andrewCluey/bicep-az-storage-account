resource subnet 'Microsoft.Network/virtualNetworks/subnets@2022-09-01' existing = {
  name: 'vn-testing-01/sn-testing-01'
  scope: resourceGroup('rg-testing-a')
}

module stgModule 'br:acrbicep.azurecr.io/bicep/modules/storage:v1.1.0' = {
  name: 'storageDeploy'
  params: {
    location: 'uksouth'
    name: 'satest86rutfuf'
    private_endpoint_blob_name: 'pesatest86rutfuf'
    subnet_id: subnet.id
    tags: {
      environment: 'dev'
    }
  }
}


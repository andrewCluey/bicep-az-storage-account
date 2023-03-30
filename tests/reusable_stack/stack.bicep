// Bicep deployment using linked modules 

// Using parameters means this `stack` can easily be re-deployed using a `Template Spec`
param subnet_name string

param subnet_resource_group string

param deployment_name string

@allowed([
  'uksouth'
  'ukwest'
])
param location string

param storage_account_name string

// Lookup the existing subnet using input parameters
resource subnet 'Microsoft.Network/virtualNetworks/subnets@2022-09-01' existing = {
  name: subnet_name
  scope: resourceGroup(subnet_resource_group)
}


// Reference the linked module in a Private Bicep Registry
module stgModule 'br:acrbicep.azurecr.io/bicep/modules/storage:v1.1.0' = {
  name: deployment_name
  params: {
    location: location
    name: storage_account_name
    private_endpoint_blob_name: 'pe${storage_account_name}'
    subnet_id: subnet.id
  }
}





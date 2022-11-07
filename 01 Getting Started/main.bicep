param location string = resourceGroup().location
param storageAccountName string = 'storage${uniqueString(resourceGroup().id)}'
param storageAccountType string = 'Standard_LRS'

var storageAccountKind = 'StorageV2'

resource storageAccount 'Microsoft.Storage/storageAccounts@2021-04-01' = {
  name: storageAccountName
  location: location
  kind: storageAccountKind
  sku: {
    name: storageAccountType
  }
  properties: {
    minimumTlsVersion: 'TLS1_2'
  }
}

output storageAccountEndpoint string = storageAccount.properties.primaryEndpoints.blob

param location string = resourceGroup().location

module storage1 'storageAccount.bicep' = {
  name: 'storage1'
  params: {
    storageAccountName: 'storage1${uniqueString(resourceGroup().id)}'
    storageAccountType: 'Standard_LRS'
    location: location
  }
}

module storage2 'storageAccount.bicep' = {
  name: 'storage2'
  params: {
    storageAccountName: 'storage2${uniqueString(resourceGroup().id)}'
    storageAccountType: 'Standard_GRS'
    location: location
  }
}

module storage3 'storageAccount.bicep' = {
  name: 'storage3'
  params: {
    storageAccountName: 'storage3${uniqueString(resourceGroup().id)}'
    storageAccountType: 'Premium_LRS'
    location: location
  }
}

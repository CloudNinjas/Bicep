# Let's go

After you have installed bicep and the VS Code extension, you can start writing your first bicep file. The first thing you need to do is to create a new file with the extension .bicep. In this example, I will create a file called main.bicep. The next step is to add the following code to the file:

```bicep	
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
```

This code will create a storage account in the resource group where the bicep file is deployed. The code is divided into four parts:

- Parameters
- Variables
- Resources
- Outputs

## Deploy Resources

The next thing you need to do is to deploy the resources. To do this, you need to run the following command:

```powershell
$resourceGroupName = 'RG-BicepDemo'
az group create --name $resourceGroupName --location westeurope
az deployment group create --resource-group $resourceGroupName --template-file main.bicep
```

## Delete Resources

To delete the resources, you need to run the following command:

```powershell
az group delete --name $resourceGroupName
```
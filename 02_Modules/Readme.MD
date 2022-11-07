# Bicep Modules

## What is a Bicep Module?

A Bicep Module is a reusable Bicep file that can be referenced by other Bicep files. Modules can be used to encapsulate a set of resources that are commonly deployed together. Modules can also be used to parameterize a set of resources that are commonly deployed together.

## How do I create a Bicep Module?

To create a Bicep Module, you need to create a Bicep file with the extension .bicep. In the following example we create a Bicep Module that creates a Storage Account. The file is called storageAccount.bicep and has 3 parameters. The first parameter is the location of the Storage Account. The second parameter is the name of the Storage Account. The third parameter is the SKU of the Storage Account.

```bicep 
param location string = resourceGroup().location
param storageAccountName string
param storageAccountType string

resource storageaccount 'Microsoft.Storage/storageAccounts@2022-05-01' = {
  name: storageAccountName
  location: location
  kind: 'StorageV2'
  sku: {
    name: storageAccountType
  }
}
```

## How do I reference a Bicep Module?

To reference a Bicep Module, you need to use the module keyword. In the following example we reference the Bicep Module that we created in the previous section. 

```bicep

module storage1 'storageAccount.bicep' = {
  name: 'storage1'
  params: {
    storageAccountName: 'storage1${uniqueString(resourceGroup().id)}'
    storageAccountType: 'Standard_LRS'
    location: location
  }
}
```

We create out main.bicep and create 3 storage accounts using the module we created earlier.

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
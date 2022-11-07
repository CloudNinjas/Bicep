# Bicep Github Action Pipeline

You can run the bicep configuration with a github action pipeline really easily. The following steps are required:

- Create an azure service principal
- Configure the Github secrets
- Create a new folder called .github/workflows
- Create a new file called bicep.yml

## Create an azure service principal

To create an azure service principal, you need to run the following command:

```powershell
az ad sp create-for-rbac --name "BicepPipeline" --role contributor --scopes /subscriptions/<SUBSCRIPTION_ID> --sdk-auth
```

This command will return a json object with the following structure:

```json
{
  "clientId": "<GUID>",
  "clientSecret": "<GUID>",
  "subscriptionId": "<GUID>",
  "tenantId": "<GUID>",
    ...
}
```

## Create a new folder called 

1. In Github, navigate to your repository. 
2. Select Security > Secrets and variables > Actions > New repository secret.
3. Paste the entire JSON output from the Azure CLI command into the secret's value field. Name the secret AZURE_CREDENTIALS.
4. Create another secret named AZURE_RG. Add the name of your resource group to the secret's value field ('RG-BicepTest').
5. Create another secret named AZURE_SUBSCRIPTION. Add your subscription ID to the secret's value field (example: 90fd3f9d-4c61-432d-99ba-1273f236afa2).

## Add Bicep file to Repository

```bicep

@minLength(3)
@maxLength(11)
param storagePrefix string

@allowed([
  'Standard_LRS'
  'Standard_GRS'
  'Standard_RAGRS'
  'Standard_ZRS'
  'Premium_LRS'
  'Premium_ZRS'
  'Standard_GZRS'
  'Standard_RAGZRS'
])
param storageSKU string = 'Standard_LRS'

param location string = resourceGroup().location

var uniqueStorageName = '${storagePrefix}${uniqueString(resourceGroup().id)}'

resource stg 'Microsoft.Storage/storageAccounts@2021-04-01' = {
  name: uniqueStorageName
  location: location
  sku: {
    name: storageSKU
  }
  kind: 'StorageV2'
  properties: {
    supportsHttpsTrafficOnly: true
  }
}

output storageEndpoint object = stg.properties.primaryEndpoints

```

## Create workflow

A workflow defines the steps to execute when triggered. It's a YAML (.yml) file in the .github/workflows/ path of your repository. The workflow file extension can be either .yml or .yaml.
Create a bicep.yml file in your .github/workflows folder and replace the contents with the following:

```yaml

on: [push]
name: Azure ARM
jobs:
  build-and-deploy:
    runs-on: ubuntu-latest
    steps:

      # Checkout code
    - uses: actions/checkout@main

      # Log into Azure
    - uses: azure/login@v1
      with:
        creds: ${{ secrets.AZURE_CREDENTIALS }}

      # Deploy Bicep file
    - name: deploy
      uses: azure/arm-deploy@v1
      with:
        subscriptionId: ${{ secrets.AZURE_SUBSCRIPTION }}
        resourceGroupName: ${{ secrets.AZURE_RG }}
        template: ./main.bicep
        parameters: 'storagePrefix=bicepdemo storageSKU=Standard_LRS'
        failOnStdErr: false
```

## Commit and push your code

Commit your code and see the magic happening :) 
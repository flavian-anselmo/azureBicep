
/*
azure bicep 

*/
@description('Specifies the location for resources.')
param location string = resourceGroup().location
param name string = resourceGroup().name
resource storageAccount 'Microsoft.Storage/storageAccounts@2021-08-01'={
  kind:'StorageV2'
  location:location
  name:name 
  sku:{
    name:'Standard_LRS'
  }
  properties:{
    accessTier:'Hot'
  }
}



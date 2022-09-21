
/*
azure bicep 

*/
@description('Specifies the location for resources.')
param location string = 'Westus3'
param storageAccountName string = 'sportsbikestorageaccount${uniqueString(resourceGroup().id)}'
param appServiceAppName string = 'sportBikeProductLauch${uniqueString(resourceGroup().id)}'
var servicePlanName = 'sportBike-launch-plan'
resource storageAccount 'Microsoft.Storage/storageAccounts@2021-08-01'={
  kind:'StorageV2'
  location:location
  name:storageAccountName
  sku:{
    name:'Standard_LRS'
  }
  properties:{
    accessTier:'Hot'
  }
}




resource appServicePlan 'Microsoft.Web/serverfarms@2021-03-01'={
  name:servicePlanName
  location:location
  properties:{
    
  }
  sku:{
    name:'F1'
  }

}

resource appSeviceApp 'Microsoft.Web/sites@2021-03-01'={
  name:appServiceAppName
  location:location
  properties:{
    serverFarmId:appServicePlan.id
    httpsOnly:true
  }
}

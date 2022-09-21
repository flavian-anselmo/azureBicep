
/*
azure bicep 


 automatically set the SKU for each env type {

 }

*/
@description('Specifies the location for resources.')
param location string = 'westus3'
param storageAccountName string = 'sportsbikestorageaccount${uniqueString(resourceGroup().id)}'
param appServiceAppName string = 'sportBikeProductLauch${uniqueString(resourceGroup().id)}'
var servicePlanName = 'sportBike-launch-plan'


// adding envType so that we can deploy resources in both prod & non prod 
@allowed(
  [
    'dev'
    'prod'
  ]
)
/***
 {
  defining a parameter with a set of 
  allowed values but we are not 
  specifying a default value for this param 

 }
*/
param ENV string
// below the above line, add the condtions for changing the env 
var storageAccSkuName = (ENV == 'prod')? 'Standard_GRS':'Standard_LRS'
var appServicePlanSkuName =(ENV == 'prod')? 'P2V3':'F1'

resource storageAccount 'Microsoft.Storage/storageAccounts@2021-08-01'={
  kind:'StorageV2'
  location:location
  name:storageAccountName
  sku:{
    name:storageAccSkuName
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
    name:appServicePlanSkuName
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

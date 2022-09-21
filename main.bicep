
/*
azure bicep 


 automatically set the SKU for each env type {

 }

*/
@description('Specifies the location for resources.')
param location string = resourceGroup().location
param storageAccountName string = 'sbikes${uniqueString(resourceGroup().id)}'
param appServiceAppName string = 'BikeLauch${uniqueString(resourceGroup().id)}'
//var servicePlanName = 'sportBike-launch-plan'


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
//var appServicePlanSkuName =(ENV == 'prod')? 'P2V3':'F1'

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
module appService 'modules/app_service.bicep'={
  name:'appService'
  params:{
    appServiceAppName:appServiceAppName
    ENV:ENV
    location:location
    
  }
}
output appServiceAppHostName string = appService.outputs.appServiceAppHostName

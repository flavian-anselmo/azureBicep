param location string 
param appServiceAppName string 


@allowed(
  [
    // envs to choose from  
    'dev'
    'prod'
  ]
)

param ENV string

// service plan 
var servicePlanName = 'sportBike-launch-plan'

// CHOOSE btwn dev and production 
var appServicePlanSkuName = (ENV == 'prod')? 'P2V3':'F1'


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

output appServiceAppHostName string = appSeviceApp.properties.defaultHostName
/***
  This code is declaring that an output for this module,
  which will be named appServiceAppHostName, will be of type string. 
  The output will take its value 
  from the defaultHostName property of the App Service app.
*/

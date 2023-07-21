param params object
param location string = resourceGroup().location
param keyVaultName string = params.keyVaultName
param secretName string = params.secretName
var newsecretname = 'mynewsecretname'
var secret3name = 'secret3'

param secretNamesInput object
var secretNames = secretNamesInput.value


resource keyVault 'Microsoft.KeyVault/vaults@2021-10-01' = {
  name: keyVaultName
  location: location
  properties: {
    enabledForDeployment: true
    enabledForTemplateDeployment: true
    enabledForDiskEncryption: true
    tenantId: tenant().tenantId
    enableRbacAuthorization: true
    accessPolicies: []
    networkAcls: {
      bypass: 'AzureServices'
      defaultAction: 'deny'
      ipRules: [
        {
          value: '193.30.38.200/32'
        }
      ]
    }
    sku: {
      name: 'standard'
      family: 'A'
    }
  }
}


resource mySecret 'Microsoft.KeyVault/vaults/secrets@2021-11-01-preview' = if(!contains(secretNames, secretName)) {
  parent: keyVault
  name: secretName
  properties: {
    value: 'dummy'
  }
}

resource newSecret 'Microsoft.KeyVault/vaults/secrets@2021-11-01-preview' = if(!contains(secretNames, newsecretname)) {
  parent: keyVault
  name: newsecretname
  properties: {
    value: 'dummy'
  }
}

resource secret3 'Microsoft.KeyVault/vaults/secrets@2021-11-01-preview' = if(!contains(secretNames, secret3name)) {
  parent: keyVault
  name: secret3name
  properties: {
    value: 'dummy'
  }
}

output secrets array = [secretName, newsecretname, secret3name]

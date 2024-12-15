// Parámetros para configurar el despliegue
param location string = resourceGroup().location
param storageAccountName string
param keyVaultName string
param logAnalyticsWorkspaceName string
param deviceGroupName string
param intuneAdminPrincipalId string

// Crear un Storage Account para almacenar scripts o datos
resource storageAccount 'Microsoft.Storage/storageAccounts@2022-09-01' = {
  name: storageAccountName
  location: location
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
  properties: {
    accessTier: 'Hot'
  }
}

// Crear un Azure Key Vault para gestionar secretos
resource keyVault 'Microsoft.KeyVault/vaults@2022-11-01-preview' = {
  name: keyVaultName
  location: location
  properties: {
    sku: {
      family: 'A'
      name: 'standard'
    }
    tenantId: subscription().tenantId
    accessPolicies: [
      {
        tenantId: subscription().tenantId
        objectId: intuneAdminPrincipalId
        permissions: {
          secrets: [
            'get'
            'list'
            'set'
            'delete'
          ]
        }
      }
    ]
  }
}

// Crear un Log Analytics Workspace para auditorías y monitoreo
resource logAnalyticsWorkspace 'Microsoft.OperationalInsights/workspaces@2022-10-01' = {
  name: logAnalyticsWorkspaceName
  location: location
  properties: {
    retentionInDays: 30
    sku: {
      name: 'PerGB2018'
    }
  }
}

// Crear un grupo de dispositivos en Azure AD para Intune
resource deviceGroup 'Microsoft.Resources/deploymentScripts@2022-10-01' = {
  name: '${deviceGroupName}-deployment'
  location: location
  properties: {
    scriptContent: '''
      az ad group create \
        --display-name "${deviceGroupName}" \
        --mail-nickname "${deviceGroupName}" \
        --description "Device Group for Intune managed devices"
    '''
    forceUpdateTag: 'intune-deployment'
    timeout: 'PT10M'
    cleanupPreference: 'OnSuccess'
  }
}

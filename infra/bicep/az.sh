#!/bin/bash

az deployment group create \
  --resource-group <RESOURCE_GROUP_NAME> \
  --template-file <FILE_PATH>/main.bicep \
  --parameters \
    storageAccountName=<STORAGE_ACCOUNT> \
    keyVaultName=<KEYVAULT_NAME> \
    logAnalyticsWorkspaceName=<LOG_ANALYTICS_NAME> \
    deviceGroupName=<DEVICE_GROUP> \
    intuneAdminPrincipalId=<ADMIN_OBJECT_ID>

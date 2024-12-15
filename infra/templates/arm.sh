#!/bin/bash

az deployment group create \
  --resource-group <RESOURCE_GROUP_NAME> \
  --template-file <PATH_TO_TEMPLATE>/template.json \
  --parameters storageAccountName=<STORAGE_ACCOUNT_NAME> \
               keyVaultName=<KEYVAULT_NAME> \
               logAnalyticsWorkspaceName=<LOG_ANALYTICS_NAME> \
               deviceGroupName=<DEVICE_GROUP_NAME> \
               intuneAdminPrincipalId=<INTUNE_ADMIN_PRINCIPAL_ID>

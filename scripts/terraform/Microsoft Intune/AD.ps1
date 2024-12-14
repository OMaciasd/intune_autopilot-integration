New-AzureADMSConditionalAccessPolicy -DisplayName "Secure Access" -Conditions @{
 Devices = @{
  DeviceStates = @{ExcludeStates = @("Compliant") }
 }
}

Set-AzureADPasswordPolicy -MinimumLength 12 -RequireComplexity $true -ExpiryInDays 90

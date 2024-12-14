Import-Module IntuneManagement
Set-IntuneDeviceConfigurationPolicy -Name "Basic Security" -Settings @{
    "Firewall" = "Enabled";
    "SmartScreen" = "Enabled";
}

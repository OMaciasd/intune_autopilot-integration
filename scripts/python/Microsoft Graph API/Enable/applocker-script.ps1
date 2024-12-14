# Habilitar AppLocker
Set-Service -Name AppIDSvc -StartupType Automatic
Start-Service -Name AppIDSvc

# Crear una regla para permitir la ejecución de aplicaciones en "C:\Program Files"
$Rule = New-AppLockerPolicy -Allow -Path "C:\Program Files\*" -RuleType "Executable"
Set-AppLockerPolicy -PolicyObject $Rule -Merge

# Crear una regla para bloquear "C:\Program Files\UnwantedApp"
$Rule = New-AppLockerPolicy -Deny -Path "C:\Program Files\UnwantedApp" -RuleType "Executable"
Set-AppLockerPolicy -PolicyObject $Rule -Merge

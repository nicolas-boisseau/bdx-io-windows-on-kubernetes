param (
    [string]$ConfigurationFolder = "c:\startup\Configuration",
    [string]$TargetAppFolder = "c:\inetpub\wwwroot\"    
)

Write-Host "Looking Configuration folder..."
$successful = $False
if (Test-Path $ConfigurationFolder) {
    Write-Host "Setup symbolik links for each of the configuration files..."

    $configFiles = Get-ChildItem $ConfigurationFolder
    $mappedFiles = 0
    foreach ($configFile in $configFiles) {
        if ($configFile -notlike "..*") {
            $targetFilePath = $configFile.Name.Replace("__", "\\")
            New-Item -Path "$TargetAppFolder\$targetFilePath" -ItemType SymbolicLink -Value "$($configFile.FullName)" -Force -Verbose > $null
            $mappedFiles++
        }
    }
    $successful = $mappedFiles -gt 0
}

if (-not $successful) {
    Write-Host "/!\ FATAL : Unable to load the appropriate configuration." -ForegroundColor Red
    Write-Host "    Is CONFIG_LOCATION environment variable defined ? Is configuration volume mounted ?" -ForegroundColor Red
    Write-Host "Exiting..." -ForegroundColor Red
    exit -1
}

exit 0

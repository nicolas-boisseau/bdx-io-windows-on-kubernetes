# Applying configuration from CONFIG_LOCATION path
C:\Startup\SetConfigurationV2.ps1 -ConfigurationFolder "$($env:CONFIG_LOCATION)" -TargetAppFolder "C:\App\";

$exitCode = $LASTEXITCODE
if ($exitCode -ne 0) { exit $exitCode }

$e2eCertStoreLocation = "Cert:\LocalMachine\My";
$certificatesStoreLocation = "Cert:\CurrentUser\My";

if (-not [string]::IsNullOrEmpty($env:E2E_TLS_CERTIFICATES_STORE_LOCATION)) { $e2eCertStoreLocation = $env:E2E_TLS_CERTIFICATES_STORE_LOCATION };
if (-not [string]::IsNullOrEmpty($env:CERTIFICATES_STORE_LOCATION)) { $certificatesStoreLocation = $env:CERTIFICATES_STORE_LOCATION };

# End-to-end TLS Certificates : adding ssl bindings to IIS site
if (-not [string]::IsNullOrEmpty($env:E2E_TLS_CERTIFICATES)) {
    Write-Host "Adding Ssl Binding..."
    Import-Module IISAdministration;
    Import-Module WebAdministration; 
    
    $env:E2E_TLS_CERTIFICATES.Split(",") | Foreach-Object {
        $tlsCertificatePath = "$env:KV_SECRETS_PATH\$_.pfx";
        Write-Host $tlsCertificatePath
        $cert = Import-PfxCertificate -Exportable -FilePath $tlsCertificatePath -CertStoreLocation $e2eCertStoreLocation;
        $commonName = $($cert.Subject.Split(",") | ConvertFrom-StringData).CN;
        Write-Host "CN: $commonName, Thumbprint: $($cert.Thumbprint)";
        # Create ssl binding with SNI 
        New-Item -Path IIS:\SslBindings\0.0.0.0!443!$commonName -Value $cert -SslFlags 1;    
    }       
    # Create default ssl binding without SNI
    New-Item -Path IIS:\SslBindings\0.0.0.0!443 -Value $cert;
    Write-Host "Ssl bindings were successfully added!"
}

# Import certificates
if (-not [string]::IsNullOrEmpty($env:CERTIFICATES)) {
    Write-Host "Importing certificates..."
    $env:CERTIFICATES.Split(",") | Foreach-Object {
        $certificatePath = "$env:KV_SECRETS_PATH\$_.pfx";
        Write-Host $certificatePath
        Import-PfxCertificate -Exportable -FilePath $certificatePath -CertStoreLocation $certificatesStoreLocation;       
    }
    # FIX Bug Eureka EP Secured : certificat EuroInformation
    icacls.exe "C:\ProgramData\Microsoft\Crypto\RSA\MachineKeys\*" /grant 'NT AUTHORITY\NETWORK SERVICE:F'    
    icacls.exe "C:\ProgramData\Microsoft\Crypto\RSA\MachineKeys\*" /grant 'IIS APPPOOL\.NET v4.5:R'
    icacls.exe "C:\ProgramData\Microsoft\Crypto\RSA\MachineKeys\*" /grant 'IIS APPPOOL\DefaultAppPool:R'

    Write-Host "Certificates were successfully imported!"
}

# The default entry point
C:\\LogMonitor\\LogMonitor.exe C:\ServiceMonitor.exe w3svc;